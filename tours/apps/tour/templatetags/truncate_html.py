from django import template
 
register = template.Library()

import re

tag_end_re = re.compile(r'(\w+)[^>]*>')
entity_end_re = re.compile(r'(\w+;)')

@register.filter
def truncate_html(string, length, ellipsis='...'):
    """Truncate HTML string, preserving tag structure and character entities."""
    length = int(length)
    output_length = 0
    i = 0
    pending_close_tags = {}
    
    while output_length < length and i < len(string):
        c = string[i]

        if c == '<':
            # probably some kind of tag
            if i in pending_close_tags:
                # just pop and skip if it's closing tag we already knew about
                i += len(pending_close_tags.pop(i))
            else:
                # else maybe add tag
                i += 1
                match = tag_end_re.match(string[i:])
                if match:
                    tag = match.groups()[0]
                    i += match.end()
  
                    # save the end tag for possible later use if there is one
                    match = re.search(r'(</' + tag + '[^>]*>)', string[i:], re.IGNORECASE)
                    if match:
                        pending_close_tags[i + match.start()] = match.groups()[0]
                else:
                    output_length += 1 # some kind of garbage, but count it in
                    
        elif c == '&':
            # possible character entity, we need to skip it
            i += 1
            match = entity_end_re.match(string[i:])
            if match:
                i += match.end()

            # this is either a weird character or just '&', both count as 1
            output_length += 1
        else:
            # plain old characters
            
            skip_to = string.find('<', i, i + length)
            if skip_to == -1:
                skip_to = string.find('&', i, i + length)
            if skip_to == -1:
                skip_to = i + length
                
            # clamp
            delta = min(skip_to - i,
                        length - output_length,
                        len(string) - i)

            output_length += delta
            i += delta
                        
    output = [string[:i]]
    if output_length == length:
        output.append(ellipsis)

    for k in sorted(pending_close_tags.keys()):
        output.append(pending_close_tags[k])

    return "".join(output)


truncate_html.is_safe = True