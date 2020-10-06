from flask.json import jsonify
import requests, re
from flask import Flask, request, make_response,  render_template
app = Flask(__name__)

regex = re.compile(r'^((?:http(?:s)?:\/\/)?)((?:www\.)?[a-zA-Z0-9@:%._\+~#=]{2,256}\.[a-z]{2,6}\b)((?:\:\d+)?)((?:[-\w@:%\+.~#&/=]*)?)((?:\?[-\w%\+.~#&=]*)?)$', re.IGNORECASE)


@app.route('/', methods=['GET'])
def index():
    return jsonify({"Endpoints":[["/source",{"Method":"GET","Param":{"value":"view","type":"bool"}}],["/getHeader",{"Method":"POST","Param":{"value":"url","type":"string"},"Example":{"Request":"url=http://example.com","Response":{"Content-Encoding":"gzip","Accept-Ranges":"bytes","Age":"349563","Cache-Control":"max-age=604800","Content-Type":"text/html; charset=UTF-8","Date":"Tue, 06 Oct 2020 09:37:06 GMT","Etag":"3147526947","Expires":"Tue, 13 Oct 2020 09:37:06 GMT","Last-Modified":"Thu, 17 Oct 2019 07:18:26 GMT","Server":"ECS (oxr/832D)","Vary":"Accept-Encoding","X-Cache":"HIT","Content-Length":"648"}}}]]}),200   
 

@app.route('/getHeader', methods=['POST'])
def header():
    if request.form.get('url'):
        url = request.form.get('url')
        if re.match(regex, url):
            res = requests.get(url,allow_redirects=True)
            return jsonify(dict(res.headers)),200
        else:
            return jsonify({"error":"Given input is not url"}),200
    else:
        return jsonify({"error":"Something Went Wrong!"}),200

@app.route('/source', methods=['GET'])
def source():
    if request.args.get('view'):
        value = request.args.get('view') 
        if(value=="true"):
            return render_template('source.html')
        else:
            return '',201 
    else:
        return '',201


if __name__ == '__main__':
    app.run()