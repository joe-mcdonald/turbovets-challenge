import { Routes } from '@angular/router';
import { Header } from './header/header';


export const routes: Routes = [
    {
        path: '',
        component: Header,
        children: [
            // all the routes for the application
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
            // default route
            { 
                path: '', 
                redirectTo: 'tickets', 
                pathMatch: 'full' 
            },
            // 404 route
            { 
                path: '**', 
                redirectTo: 'tickets'
            } 
        ]
    }
];
