jQuery ->
  Morris.Line
    element: 'ex-graph'
    data: $('#ex-graph').data('rates')
    xkey: 'date'
    ykeys: ['exchange_rate']
    labels: ['Exchange Rate']
