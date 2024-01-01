from flask import Flask

def create_app(config=None):
    app = Flask("CineBookAPI")

    @app.route("/")
    def index():
        res = {
            'Health' : 'Healthy!'
        }
        return res, 200
    
    return app