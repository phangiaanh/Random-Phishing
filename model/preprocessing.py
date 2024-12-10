import re
from urllib.parse import urlparse
import numpy as np

class Preprocessing:
    def __init__(self) -> None:
        # Regular expression patterns
        self.IPV4_PATTERN = r'((([01]?\d\d?|2[0-4]\d|25[0-5])\.){3}([01]?\d\d?|2[0-4]\d|25[0-5])\/?)'
        self.IPV4_HEX_PATTERN = r'((0x[0-9a-fA-F]{1,2}\.){3}(0x[0-9a-fA-F]{1,2})\/?)'
        self.IPV6_PATTERN = r'((?:[a-fA-F0-9]{1,4}:){7}[a-fA-F0-9]{1,4})'
        self.IPV4_WITH_PORT_PATTERN = r'(([0-9]+(?:\.[0-9]+){3}:[0-9]+))'
        self.IPV4_CIDR_PATTERN = r'((?:(?:\d|[01]?\d\d|2[0-4]\d|25[0-5])\.){3}(?:25[0-5]|2[0-4]\d|[01]?\d\d|\d)(?:\/\d{1,2})?)'
        
        # Define a list of known URL shortening services
        self.SHORTENING_SERVICES = [
            "bit.ly", "goo.gl", "shorte.st", "go2l.ink", "x.co", "ow.ly", "t.co", "tinyurl", "tr.im", "is.gd", "cli.gs",
            "yfrog.com", "migre.me", "ff.im", "tiny.cc", "url4.eu", "twit.ac", "su.pr", "twurl.nl", "snipurl.com",
            "short.to", "BudURL.com", "ping.fm", "post.ly", "Just.as", "bkite.com", "snipr.com", "fic.kr", "loopt.us",
            "doiop.com", "short.ie", "kl.am", "wp.me", "rubyurl.com", "om.ly", "to.ly", "bit.do", "lnkd.in", "db.tt",
            "qr.ae", "adf.ly", "bitly.com", "cur.lv", "tinyurl.com", "ity.im", "q.gs", "po.st", "bc.vc", "twitthis.com",
            "u.to", "j.mp", "buzurl.com", "cutt.us", "u.bb", "yourls.org", "prettylinkpro.com", "scrnch.me", "filoops.info",
            "vzturl.com", "qr.net", "1url.com", "tweez.me", "v.gd", "link.zip.net"
        ]
        self.SLD = ["ac", "edu", "gov", "com", "org", "net"]
        pass
    
    def __call__(self, url: str):
        """
        Processing url and convert to numpy array

        Args:
            url (str): parameter is string url

        Returns:
            numpy array of sample
        """
        processed_url = [
            self.check_ip_address(url),
            self.check_long_address(url),
            self.check_short_address(url),
            self.check_redirecting_url(url),
            self.check_prefix_suffix_seperate(url),
            self.check_have_symbol(url),
            self.check_multi_subdomain(url),
            self.check_secure_https(url)
        ]
        return np.array(processed_url)
    
    def check_ip_address(self, url: str):
        """
        Check the url has IP digital or not
        
        Args:
            url (str): parameter is string url
        Returns:
            1: legit
            -1: phishing
        """
        # Combine all patterns
        combined_pattern = (
            rf"{self.IPV4_PATTERN}|"
            rf"{self.IPV4_WITH_PORT_PATTERN}|"
            rf"{self.IPV4_HEX_PATTERN}|"
            rf"{self.IPV6_PATTERN}|"
            rf"{self.IPV4_CIDR_PATTERN}"
        )

        # Match against the given URL
        match = re.search(combined_pattern, url)
        return -1 if match else 1
    
    
    def check_long_address(self, url: str):
        """
        Check standart length of url
        
        Args:
            url (str): parameter is string url
        Returns:
            1: legit
            -1: phishing
        """
        if len(url) < 54:
            return 1
        if len(url) >= 54 and len(url) < 75:
            return 0
        return -1
    
    def check_short_address(self, url: str):
        """
        Check shortening services -> tiny url
        
        Args:
            url (str): parameter is string url
        Returns:
            1: legit
            -1: phishing
        """
        tiny_url = r'|'.join(re.escape(service) for service in self.SHORTENING_SERVICES)
        match = re.search(tiny_url, url)
        return -1 if match else 1
    
    def check_have_symbol(self, url: str):
        """
        Check the url has special symbol
        
        Args:
            url (str): parameter is string url
        Returns:
            1: legit
            -1: phishing
        """
        return 1 if url.find('@') == -1 else -1
    
    def check_redirecting_url(self, url: str):
        """
        Check the url use redirecting other url by "//"
        
        Args:
            url (str): parameter is string url
        Returns:
            1: legit
            -1: phishing
        """
        double_slash_index = url.find("//")
        print(double_slash_index)
        # check URL start with HTTP or HTTPS
        if url.startswith("http://"):
            valid_position = 6
        elif url.startswith("https://"):
            valid_position = 7
        else:
            return -1

        position = url.find("//", valid_position + 1)
        return -1 if position != -1 else 1
    
    def check_prefix_suffix_seperate(self, url: str):
        """
        Check the url use symbol seperate by "-"
        
        Args:
            url (str): parameter is string url
        Returns:
            1: legit
            -1: phishing
        """
        return -1 if url.find('-') != -1 else 1

    
    def check_multi_subdomain(self, url: str):
        """
        Check multi subdomain in url

        Args:
            url (str): parameter is string url
        Returns:
            1: legit
            -1: phishing
            0: suspicious
        """
        # remove 'http://', 'https://' và 'www.' if exist
        if url.startswith("http://"):
            url = url[7:]
        elif url.startswith("https://"):
            url = url[8:]
        if url.startswith("www."):
            url = url[4:]

        # split primary domain (remove path)
        domain = url.split('/')[0]

        # split parts in domain
        parts = domain.split('.')
        
        # remove ccTLD and SLD (ex:'uk', 'ac.uk')
        if len(parts) > 2 and parts[-1].isalpha() and len(parts[-1]) <= 3:  # ccTLD
            parts.pop()  # remove ccTLD
        if len(parts) > 1 and parts[-1] in self.SLD:  # SLD popular
            parts.pop()  # remove SLD
            
        # count remain dot
        subdomain_count = len(parts) - 1

        # classify by sub-domains
        if subdomain_count == 0:
            return 1  
        elif subdomain_count == 1:
            return 0  
        return -1  
    
    def check_secure_https(self, url: str):
        """
        Check the url has secure certificate

        Args:
            url (str): parameter is string url
        Returns:
            1: legit
            -1: phishing
        """
        return 1 if urlparse(url).scheme == 'https' else -1

        
        
    
        
    
# if __name__ == '__main__':
#     test = Preprocessing()
#     print(test.check_ip_address('https://192.168.1.12'))
#     print(test.check_ip_address('https://google.com'))
        
        
        
#     print(test.check_long_address('https://google.com'))
#     print(test.check_short_address('https://bitly.com.vn'))
#     print(test.check_have_symbol('https://www.facebook.com@@'))
#     print(test.check_have_symbol('https://www.facebook.com'))
    
#     print(test.check_redirecting_url('http://www.facebook.com'))
#     print(test.check_redirecting_url('https://www.facebook.com//'))
#     print(test.check_prefix_suffix_seperate('https://facebook.com-'))
#     print(test.check_multi_subdomain('https://facebook.com.vn.uk'))
#     print(test.check_multi_subdomain('https://facebook.com.vn'))
#     print(test.check_multi_subdomain('http://example.com'))
    