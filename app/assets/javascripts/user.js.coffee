jQuery ->
  Morris.Line
    element: 'ex-graph'
    data: $('#ex-graph').data('rates')
    xkey: 'date'
    xLabels: 'Date'
    ykeys: ['exchange_rate']
    labels: ['Exchange Rate']
    ymin: 'auto'
    smooth: false
    yLabelFormat: `function (y) { return y.toFixed(6); }`

