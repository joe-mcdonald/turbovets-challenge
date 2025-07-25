import { Component } from '@angular/core';
import { CommonModule } from '@angular/common';
import { RouterModule } from '@angular/router';

interface Ticket {
  id: number;
  subject: string;
  status: 'Open' | 'In Progress' | 'Closed';
  createdAt: String;
}

@Component({
  standalone: true,
  selector: 'app-ticket-viewer',
  imports: [CommonModule, RouterModule],
  templateUrl: './ticket-viewer.html',
  styleUrl: './ticket-viewer.css'
})

export class TicketViewer {
  selectedStatus: 'All' | 'Open' | 'In Progress' | 'Closed' = 'All';
  tickets: Ticket[] = [
    { id: 1, subject: 'Issue with login', status: 'Closed', createdAt: '2025-01-02' },
    { id: 2, subject: 'Images not sending', status: 'In Progress', createdAt: '2025-01-02' },
    { id: 3, subject: 'Password requirements verification not working', status: 'In Progress', createdAt: '2025-01-02' },
    { id: 4, subject: 'Message timestamps not updating across time zones', status: 'Open', createdAt: '2025-01-07' },
    { id: 5, subject: 'Add spam protection', status: 'Open', createdAt: '2025-01-11' },
    // { id: 6, subject: '', status: 'Open', createdAt: '2025-01-14' },
    // { id: 7, subject: 'Issue with login', status: 'Open', createdAt: '2025-01-22' },
    // { id: 8, subject: 'Issue with login', status: 'Open', createdAt: '2025-02-02' },
    // { id: 9, subject: 'Issue with login', status: 'Open', createdAt: '2025-01-31' },
  ];

  get filteredTickets(): Ticket[] {
    if (this.selectedStatus === 'All') return this.tickets;
    return this.tickets.filter(t => t.status === this.selectedStatus);
  }

  setStatusFilter(status: 'All' | 'Open' | 'In Progress' | 'Closed') {
    this.selectedStatus = status;
  }
}