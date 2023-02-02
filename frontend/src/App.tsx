import { useEffect, useState } from "react";
import "./App.css";

const apiUrl = "/api/music";

function App() {
  const [isPlaying, setIsPlaying] = useState(false);

  useEffect(() => refreshIsPlaying, []);

  const playMusic = () => {
    fetch(`${apiUrl}/start`, { method: "POST" }).then(refreshIsPlaying);
  };

  const stopMusic = () => {
    fetch(`${apiUrl}/stop`, { method: "POST" }).then(refreshIsPlaying);
  };

  const refreshIsPlaying = () => {
    fetch(apiUrl)
      .then((resp) => resp.json())
      .then((resp) => {
        if (resp?.isPlaying) {
          setIsPlaying(true);
        } else {
          setIsPlaying(false);
        }
      });
  };

  return (
    <div className="App">
      <h1>Smart Terrarium</h1>
      <div className="card">
        <span>Music is {!isPlaying && "not"} playing.</span>
        <button onClick={playMusic}>Play Music</button>
        <button onClick={stopMusic}>Stop Music</button>
      </div>
    </div>
  );
}

export default App;
