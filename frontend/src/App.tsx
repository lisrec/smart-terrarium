import "./App.css";

function App() {
  const playMusic = () => {
    fetch("/api/start");
  };

  const stopMusic = () => {
    fetch("/api/stop");
  };

  return (
    <div className="App">
      <h1>Smart Terrarium</h1>
      <div className="card">
        <button onClick={playMusic}>Play Music</button>
        <button onClick={stopMusic}>Stop Music</button>
      </div>
    </div>
  );
}

export default App;
