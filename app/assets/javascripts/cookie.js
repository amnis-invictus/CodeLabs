class Cookie {
    constructor(name, value, options = {}) {
        this.name = name;
        this.value = value;
        this.options = options;
    }

    delete() {
        this.options.expires = -1;

        this.setCookie();

        return false;
    }

    get() {
        const matches = document.cookie.match(new RegExp(
            "(?:^|; )" + this.name.replace(/([\.$?*|{}\(\)\[\]\\\/\+^])/g, '\\$1') + "=([^;]*)"
        ));

        return matches ? decodeURIComponent(matches[1]) : undefined;
    }

    set() {
        let expires = this.options.expires;

        if (typeof expires === "number" && expires) {
            const d = new Date;

            d.setTime(d.getTime() + expires * 1000);
            expires = this.options.expires = d;
        }
        if (expires && expires.toUTCString) {
            this.options.expires = expires.toUTCString();
        }

        let value = encodeURIComponent(this.value),
            updatedCookie = name + "=" + value;

        for (let propName in options) {
            updatedCookie += "; " + propName;

            let propValue = options[propName];

            if (propValue !== true) {
                updatedCookie += "=" + propValue;
            }
        }

        document.cookie = updatedCookie;

        return false;
    }
}