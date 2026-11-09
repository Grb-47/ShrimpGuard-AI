export default function PagePlaceholder({ title, description, items = [] }) {
  return (
    <div className="panel">
      <h2>{title}</h2>
      <p className="muted">{description}</p>
      {items.length > 0 ? (
        <ul className="checklist">
          {items.map((item) => (
            <li key={item}>{item}</li>
          ))}
        </ul>
      ) : null}
      <p className="note">
        This screen is part of the Week 02 foundation. It will be connected to
        the Node.js API in a later phase.
      </p>
    </div>
  );
}
