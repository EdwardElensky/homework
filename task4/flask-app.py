import emoji
from emoji import emojize
# import json  # no used
from flask import Flask, request
app = Flask(__name__)

print(emoji.emojize(':cookie:'))
print("\N{grinning face}")
print("\U0001F606")
# @app.route('/')
# def index():
#    return "\N{winking face} Hello world"


@app.route('/', methods=['GET', 'POST']) # of course, I can do it separately.
def json_req():
    if request.method == 'GET':
        return '''This app wait your POST request.
        Example: curl -XPOST -d'{"word":"cat", "count": 5}' http://hostname/ '''
    if request.method == 'POST':
        request_data = request.get_json(force=True)
    i = 1  # add counter
    answer = emojize(":cookie:") # I need more words
    data = request.get_json()
    while i <= data["count"]:  # Stackoverflow, I love you!
        answer = answer + data["word"] + emojize(":cookie:")
        i += 1

    ans = answer + '\n'

    return ans


# ---------------------------
# example (bad)
# @app.route("/me")
# def me_api():
#    user = get_current_user()
#    return {
#        "username": user.username,
#        "theme": user.theme,
#        "image": url_for("user_image", filename=user.image),
#    }
#
# @app.route("/users")
# def users_api():
#    users = get_all_users()
#    return jsonify([user.to_json() for user in users])
# ----------------------------


if __name__ == "__main__":
    app.run(host='0.0.0.0', port=1080, debug=True) # I need 80th port !!!!!!
