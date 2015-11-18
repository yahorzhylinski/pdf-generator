function draw(labels, canvasId, label1, data1, label2, data2) {    

  var data = {
    labels: labels,
    datasets: [
      {
        label: label1,
        fillColor: "rgba(220,220,220,0.2)",
        strokeColor: "rgba(220,220,220,1)",
        pointColor: "rgba(220,220,220,1)",
        pointStrokeColor: "#fff",
        pointHighlightFill: "#fff",
        pointHighlightStroke: "rgba(220,220,220,1)",
        data: data1
      }
    ]
  };

  if(label2) {
    data.datasets.push(
      {
        label: label2,
        fillColor: "rgba(151,187,205,0.2)",
        strokeColor: "rgba(151,187,205,1)",
        pointColor: "rgba(151,187,205,1)",
        pointStrokeColor: "#fff",
        pointHighlightFill: "#fff",
        pointHighlightStroke: "rgba(151,187,205,1)",
        data: data2
      }
    );
  }

  var ctx = document.getElementById(canvasId).getContext("2d");
  var myNewChart = new Chart(ctx).Line(data);
}
