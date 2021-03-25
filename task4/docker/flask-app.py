import emoji
from emoji import emojize
from flask import Flask, request
app = Flask(__name__)

# ---- test area ----(can be removed)--
# https://unicode.org/Public/emoji/13.1/emoji-sequences.txt
print(emoji.emojize(':cookie:'))
print(emoji.emojize(':cat:'))
print(emoji.emojize(':dog:'))
print(emoji.emojize(':camel:'))
print(emoji.emojize(':eyes:'))
print(emoji.emojize(':pig:'))
print(emoji.emojize(':ram:'))
print(emoji.emojize(':snail:'))
print(emoji.emojize(':dragon:'))
print(emoji.emojize(':boy:'))
print(emoji.emojize(':house:'))
print(emoji.emojize(':trophy:'))
print(emoji.emojize(':cyclone:'))
print(emoji.emojize(':banana:'))
print(emoji.emojize(':ewe:'))
print(emoji.emojize(':rooster:'))
print(emoji.emojize(':crab:'))
print(emoji.emojize(':beaver:'))
print(emoji.emojize(':snowflake:'))
print(emoji.emojize(':satellite:'))
# -----------end test area-------


@app.route('/', methods=['GET', 'POST'])
def json_req():
    if request.method == 'GET':
        return '''This app wait your POST request. 
        Example: curl -XPOST -d'{"word":"cat", "count": 5}' http://localhost/ '''
    if request.method == 'POST':
        data = request.get_json(force=True)
        i = 1
        answer = emojize(":" + data["word"] + ":")
        while i <= data["count"]:
            answer = answer + data["word"] + emojize(":" + data["word"] + ":")
            i += 1

        full_answer = answer + '\n'

        return full_answer


# ----------------------------


if __name__ == "__main__":
    app.run(host='0.0.0.0', port=1080, debug=False) # I need 80th port !!!!!!
