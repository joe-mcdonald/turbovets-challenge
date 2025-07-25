import { CommonModule } from '@angular/common';
import { Component, OnInit, OnDestroy, ViewChild, ElementRef } from '@angular/core';
import { RouterModule } from '@angular/router';

@Component({
  standalone: true,
  selector: 'app-live-logs',
  imports: [CommonModule, RouterModule],
  templateUrl: './live-logs.html',
  styleUrl: './live-logs.css'
})

export class LiveLogs {
  logs: string[] = []; // Initially empty
  private intervalId: any;

  @ViewChild('logContainer') logContainer!: ElementRef<HTMLDivElement>;

  ngOnInit() {
    this.intervalId = setInterval(() => {
      const newLog = `[${new Date().toLocaleDateString()}] Event: ${this.randomEvent()}`;
      this.logs.push(newLog);
      setTimeout(() => this.scrollToBottom(), 0);
    }, 2000);
  }

  ngOnDestroy() {
    if (this.intervalId) {
      clearInterval(this.intervalId);
    }
  }

  scrollToBottom(): void {
    if (this.logContainer) {
      const el = this.logContainer.nativeElement;
      el.scrollTop = el.scrollHeight;
    }
  }

  private randomEvent(): string {
    const events = [
      'User logged in',
      'User logged out',
      'File uploaded',
      'File downloaded',
      'Warning issued',
      'Data processed',
      'Connection established',
      'Error: Connection lost',
      'System started',
      'System stopped',
      'Auth token refreshed',
      'New message received',
      'User profile updated',
    ];
    return events[Math.floor(Math.random() * events.length)];
  }
}
