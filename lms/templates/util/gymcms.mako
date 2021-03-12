<%def name="render(templateUrl)">
  <%
    import urllib2
    from django.conf import settings
    edx_env = settings.APPSEMBLER_FEATURES['ENVIRONMENT']

    # turn the partial url passed in into a fully GET-able url
    # based on which environment we're in
    if templateUrl:
      fullUrl = 'https://staging.thegymcms.com/static/' + templateUrl

      if edx_env == 'production':
        fullUrl = 'https://thegymcms.com/static/' + templateUrl

      # provided the last step worked, use a try block to pull that data from the web
      # render a hidden div if it fails, so it doesn't crash the rest of the page.
      if fullUrl:
        try:
          renderedContent = urllib2.urlopen(fullUrl).read()
        except:
          renderedContent = '<div hidden>error loading ' + fullUrl + '</div>'
  %>

  %if renderedContent:
    ${renderedContent}
  %endif
</%def>
