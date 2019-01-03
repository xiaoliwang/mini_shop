(function() {
    var memberid = 0;
    var k = document,
    g = 24 * 60 * 60 * 1000,
    i = encodeURIComponent,
    a = decodeURIComponent;
    function o(p) {
        return (typeof(p)).toLowerCase() == "string" && p !== ""
    }

    var b = {
        get: function(r) {
            var q, p;
            if (o(r)) {
                if ((p = String(k.cookie).match(new RegExp("(?:^| )" + r + "(?:(?:=([^;]*))|;|$)")))) {
                    q = p[1] ? a(p[1]) : ""
                }
            }
            return q
        },
        set: function(r, w, p, s, u, t) {
            var v = String(i(w)),
            q = p;
            if (typeof q === "number") {
                q = new Date();
                q.setTime(q.getTime() + p * g)
            }
            if (q instanceof Date) {
                v += "; expires=" + q.toUTCString()
            }
            if (o(s)) {
                v += "; domain=" + s
            }
            v += "; path=/";
            if (t) {
                v += "; secure"
            }
            k.cookie = r + "=" + v
        },
        remove: function(p, q, s, r) {
            this.set(p, "", -1, q, s, r)
        }
    };
    var mem = b.get('auth');
    if (mem) {
        /*var obj = JSON.parse(mem);
        obj = JSON.parse(obj);*/
    	var obj = eval("("+mem+")");
    	obj = eval("("+obj+")");
        memberid = obj.member_id;
    }
    function m() {
        var q = navigator.userAgent;
        var s = (navigator.platform == "Win32") || (navigator.platform == "Windows");
        var u = (navigator.platform == "Mac68K") || (navigator.platform == "MacPPC") || (navigator.platform == "Macintosh") || (navigator.platform == "MacIntel");
        if (u) {
            return "Mac"
        }
        var r = (navigator.platform == "X11") && !s && !u;
        if (r) {
            return "Unix"
        }
        var w = (String(navigator.platform).indexOf("Linux") > -1);
        if (w) {
            return "Linux"
        }
        if (s) {
            var v = q.indexOf("Windows NT 5.0") > -1 || q.indexOf("Windows 2000") > -1;
            if (v) {
                return "Win2000"
            }
            var p = q.indexOf("Windows NT 5.1") > -1 || q.indexOf("Windows XP") > -1;
            if (p) {
                return "WinXP"
            }
            var t = q.indexOf("Windows NT 5.2") > -1 || q.indexOf("Windows 2003") > -1;
            if (t) {
                return "Win2003"
            }
            var t = q.indexOf("Windows NT 6.0") > -1 || q.indexOf("Windows Vista") > -1;
            if (t) {
                return "WinVista"
            }
            var t = q.indexOf("Windows NT 6.1") > -1 || q.indexOf("Windows 7") > -1;
            if (t) {
                return "Win7"
            }
			var t = q.indexOf("Windows NT 6.2") > -1 || q.indexOf("Windows 8") > -1;
            if (t) {
                return "Win8"
            }
        }
        return "None"
    }
    var d = b.get("_okbia");
    var c = b.get("_okbib");
    var l = {
        a: "",
        b: "",
        c: ""
    };
    if (d) {
        if (c) {
            l.a = d;
            l.b = c;
            b.set("_okbia", l.a, 360, "okhqb.com");
            b.set("_okbib", l.b, 1 / 48, "okhqb.com")
        } else {
            l.a = d;
            l.b = (Math.random().toString().substr(2, 5)) + ".0.0.0";
            b.set("_okbia", l.a, 360, "okhqb.com");
            b.set("_okbib", l.b, 1 / 48, "okhqb.com")
        }
    } else {
        var j = new Date().getTime();
        j = parseInt(j / 1000);
        l.a = j + "-" + (Math.random().toString().substr(2, 8)) + ".0." + j;
        l.b = (Math.random().toString().substr(2, 5)) + ".0.0.0";
        b.set("_okbia", l.a, 360, "okhqb.com");
        b.set("_okbib", l.b, 1 / 48, "okhqb.com")
    }
    d = b.get("_okbia");
    var h = 0;
    if (d) {
        var n = d.split(".");
        if (n.length > 1) {
            if (n[1] == 0) {
                h = 1
            }
        }
    } (new Image()).src = "http://a.okhqb.com/plus/ok.php?r=" + escape(document.referrer) + "&m=" + memberid + "&l=" + (navigator.language ? navigator.language: navigator.browserLanguage) + "&n=" + h + "&p=" + escape(screen.width + "x" + screen.height) + "&v=" + escape(window.location.href) + "&b=" + escape(navigator.appName) + "&bv=" + navigator.appVersion + "&os=" + m()
})();