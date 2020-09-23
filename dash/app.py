from flask import Flask, render_template
import os
app = Flask(__name__)

@app.route('/')
def home():
   result = os.popen("uptime")
   return render_template('index.html', uptime=result.read())
if __name__ == '__main__':
   app.run()