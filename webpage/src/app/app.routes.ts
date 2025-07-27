import { Routes } from '@angular/router';
import { Dashboard } from './dashboard/dashboard';
import { Header } from './header/header';
import { TicketViewer } from './ticket-viewer/ticket-viewer';
import { KnowledgeEditor } from './knowledge-editor/knowledge-editor';
import { LiveLogs } from './live-logs/live-logs';
import { provideRouter } from '@angular/router';


export const routes: Routes = [
    {
        path: '',
        component: Header,
        children: [
            // { 
            //     path: 'dashboard', 
            //     loadComponent: () => import('./dashboard/dashboard').then(m => m.Dashboard),
            // },
            { 
                path: 'tickets', 
                loadComponent: () => import('./ticket-viewer/ticket-viewer').then(m => m.TicketViewer),
            },
            { 
                path: 'editor', 
                loadComponent: () => import('./knowledge-editor/knowledge-editor').then(m => m.KnowledgeEditor),
            },
            { 
                path: 'logs', 
                loadComponent: () => import('./live-logs/live-logs').then(m => m.LiveLogs),
            },
            { 
                path: '', 
                redirectTo: 'tickets', 
                pathMatch: 'full' }, // redirect to tickets by default
            { 
                path: '**', 
                redirectTo: 'tickets' 
            } // redirect any unknown paths to tickets
        ]
    }
];
