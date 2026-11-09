import { useState } from 'react';
import { useNavigate } from 'react-router-dom';

export default function Login() {
  const navigate = useNavigate();
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');

  function handleSubmit(event) {
    event.preventDefault();
    localStorage.removeItem('shrimguard_token');
    navigate('/');
  }

  return (
    <div className="login-shell">
      <form className="login-card" onSubmit={handleSubmit}>
        <span className="brand-mark large">SG</span>
        <h1>ShrimpGuard AI</h1>
        <p className="muted">Monitoring dashboard sign-in</p>

        <label>
          Email
          <input
            type="email"
            value={email}
            onChange={(event) => setEmail(event.target.value)}
            placeholder="farmer@example.com"
          />
        </label>

        <label>
          Password
          <input
            type="password"
            value={password}
            onChange={(event) => setPassword(event.target.value)}
            placeholder="Password"
          />
        </label>

        <button type="submit" className="button primary">
          Continue
        </button>

        <p className="note">
          Authentication is not connected to the backend in this foundation.
        </p>
      </form>
    </div>
  );
}
