import { Component, signal } from '@angular/core';
import { RouterOutlet, RouterModule } from '@angular/router';

@Component({
  standalone: true,
  selector: 'app-root',
  imports: [RouterOutlet, RouterModule],
  template: '<router-outlet></router-outlet>',
  templateUrl: './app.html',
  styleUrl: './app.css'
})
export class App {
}
