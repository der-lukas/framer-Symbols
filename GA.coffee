s = document.createElement 'script'
s.setAttribute 'src', 'https://www.googletagmanager.com/gtag/js?id=UA-122141681-1'
s.setAttribute 'async', ''
document.head.appendChild s

window.dataLayer = window.dataLayer || []

window.gtag = () -> 
    dataLayer.push arguments
window.gtag 'js', new Date()
window.gtag 'config', 'UA-122141681-1'

if window.location.href.includes 'framer.cloud'
    window.gtag 'event', 'Cloud',
        'event_category': 'Visitors'
else
    window.gtag 'event', 'Non-Cloud',
        'event_category': 'Visitors'