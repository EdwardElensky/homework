import emoji
from flask import Flask
app = Flask(__name__)

print("by names")
print(emoji.emojize('Python is :cookie:'))
print(emoji.emojize(':octocat:'))
print(emoji.emojize('Python is :thumbs_up_sign:'))
print("by codes")
print("\U0001f600")
print("\U0001F606")
print("\U0001F923")
print("in brackets")
print("\N{grinning face}")
print("\N{slightly smiling face}")
print("\N{winking face}")


@app.route('/')
def index():
    return "Hello world"


@app.route('/about')
def about():
    return "About page"


if __name__ == "__main__":
    app.run(host='0.0.0.0', port=1024, debug=True)
