<%def name="render(templateUrl)">
  <%
    import urllib2
    from django.conf import settings
    edx_env = settings.APPSEMBLER_FEATURES['ENVIRONMENT']

    ## Check if we have GYMCMS_URL defined in settings
    if settings.APPSEMBLER_FEATURES['GYMCMS_URL'] is None:
      gymcms_url = False
    else:
      gymcms_url = settings.APPSEMBLER_FEATURES['GYMCMS_URL']

    ## turn the partial url passed in into a fully GET-able url based on which environment we're in
    if templateUrl:
      ## use GYMCMS_URL defined in settings
      if gymcms_url:
        fullUrl = gymcms_url + templateUrl
        ## temporarily look at an in-progress build
        ## fullUrl = 'https://deploy-preview-809--thegymcms.netlify.app/' + templateUrl
      else:
        ## Fallback if GYMCMS_URL is not defined in settings
        if edx_env == 'staging':
          fullUrl = 'https://staging.thegymcms.com/' + templateUrl
        else:
          fullUrl = 'https://thegymcms.com/' + templateUrl

      ## provided the last step worked, use a try block to pull that data from the web render a hidden div if it fails, so it doesn't crash the rest of the page.
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
