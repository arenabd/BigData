curl -XGET 'http://195.154.168.76:9200/test-2014.03.18/BALO/_mapping/' -d '
{
BALO: {
properties: {
@timestamp: {
format: dateOptionalTime
type: date
}
title: {
type: string
}
lastModified: {
format: dateOptionalTime
type: date
}
httpStatusCode: {
type: long
}
executionTime: {
type: long
}
charSet: {
type: string
}
method: {
type: string
}
parentUrl: {
type: string
}
contentLength: {
type: long
}
url: {
type: string
}
mimeType: {
type: string
}
}
}
}'

echo ""