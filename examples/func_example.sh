function func1 {
  sleep 0.3
}
func1
sleep 0.2
sleep 0.1
function func2 {
  sleep 0.5
  func1
}
func2
