<%def name="render(templateUrl)">
  <%
    import urllib2
    from django.conf import settings
    edx_env = settings.APPSEMBLER_FEATURES['ENVIRONMENT']

    # turn the partial url passed in into a fully GET-able url
    # based on which environment we're in
    if templateUrl:
      ## Temporarily using `static` until we're ready to deploy to staging
      fullUrl = 'https://thegymcms.com/' + templateUrl

      if edx_env == 'staging':
        fullUrl = 'https://staging.thegymcms.com/' + templateUrl
        ## temporarily look at an in-progress build
        ## fullUrl = 'https://deploy-preview-650--thegymcms.netlify.app/' + templateUrl

      if edx_env == 'development':
        fullUrl = 'https://staging.thegymcms.com/' + templateUrl
        ## fullUrl = 'https://deploy-preview-650--thegymcms.netlify.app/' + templateUrl

      # provided the last step worked, use a try block to pull that data from the web
      # render a hidden div if it fails, so it doesn't crash the rest of the page.
      if fullUrl:
        try:
          renderedContent = urllib2.urlopen(fullUrl).read()
        except:
          renderedContent = '<!-- Error loading: ' + fullUrl + ' -->'
  %>

  %if renderedContent:
    ${renderedContent}
  %endif
</%def>
