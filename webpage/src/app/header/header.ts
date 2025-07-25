import { Component } from '@angular/core';
import { CommonModule } from '@angular/common';
import { RouterModule, RouterOutlet } from '@angular/router';

@Component({
  standalone: true,
  selector: 'app-header',
  imports: [CommonModule, RouterModule, RouterOutlet],
  templateUrl: './header.html',
  styleUrl: './header.css'
})
export class Header {}
