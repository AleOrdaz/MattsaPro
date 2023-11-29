import 'package:appmattsa/config/router/app_router_notifier.dart';
import 'package:appmattsa/features/auth/presentation/providers/auth_provider.dart';
import 'package:appmattsa/features/lifting/presentation/screens/processlifting/evidencesscreenafter.dart';
import 'package:appmattsa/features/lifting/presentation/screens/serviceslifting/firma.dart';
import 'package:appmattsa/features/lifting/presentation/screens/serviceslifting/pdfFinalView.dart';
import 'package:appmattsa/features/lifting/presentation/screens/serviceslifting/pdfview.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../features/auth/presentation/screens/screens.dart';
import '../../features/lifting/presentation/screens/screens.dart';

final goRouterProvider = Provider((ref) => {
      GoRouter(
          initialLocation: '/login',
          refreshListenable: ref.read(goRouterNotifierProvider),
          routes: [
            GoRoute(
              path: '/splash',
              builder: (context, state) => const CheckAuthScreen(),
            ),
            GoRoute(
              path: '/login',
              name: LoginScreen.name,
              builder: (context, state) => const LoginScreen(),
            ),
            GoRoute(
              path: '/mainlifting',
              name: MainLiftingScreen.name,
              builder: (context, state) => const MainLiftingScreen(),
            ),
            GoRoute(
              path: '/lifting/customer/:id',
              name: CustomerScreen.name,
              builder: (context, state) => CustomerScreen(liftingId: state.pathParameters['id'] ?? 'noid',),
            ),
            GoRoute(
              path: '/lifting/status/:id',
              name: StatusScreen.name,
              builder: (context, state) => StatusScreen(idLifting: state.pathParameters['id'] ?? 'noid',),
            ),
            GoRoute(
              path: '/lifting/evidence/:id',
              name: EvidenceScreen.name,
              builder: (context, state) => EvidenceScreen(idLifting: state.pathParameters['id'] ?? 'noid',),
            ),
             GoRoute(
              path: '/lifting/actividades/:id',
              name: ActividadesScreen.name,
              builder: (context, state) => ActividadesScreen(liftingId: state.pathParameters['id'] ?? 'noid',),
            ),
            GoRoute(
              path: '/lifting/firts/report/:id',
              name: ReportScreen.name,
              builder: (context, state) => ReportScreen(liftingId: state.pathParameters['id'] ?? 'noid',),
            ),
            GoRoute(
              path: '/servicelifint',
              name: MainServicesScreen.name,
              builder: (context, state) => const MainServicesScreen(),
            ),GoRoute(
              path: '/services/panel/:id',
              name: PanelGeneralSevices.name,
              builder: (context, state) => PanelGeneralSevices(liftingId: state.pathParameters['id'] ?? 'noid',),
            ),
            GoRoute(
              path: '/pdfview',
              name: Pdfview.name,
              builder: (context, state) => Pdfview(),
            ),
            GoRoute(
              path: '/lifting/evidence/after/:id',
              name: EvidenceScreenAfter.name,
              builder: (context, state) => EvidenceScreenAfter(idLifting: state.pathParameters['id'] ?? 'noid',),
            ),
            /*GoRoute(
              path: '/firma',
              name: EvidenceScreenAfter.name,
              builder: (context, state) => Firma(),
            ),*/
          ],
          redirect: (context, state) {
            final isGoingTo = state.location;
            final authStatus = ref.read(goRouterNotifierProvider).authStatus;
            print("Location: ${state.location}");
            print("Location: ${AuthStatus.notAuthenticated.name}");
            print("Location: ${authStatus.name}");
            if (isGoingTo == '/splash' && authStatus == AuthStatus.checking)
              return null;

            if (authStatus == AuthStatus.notAuthenticated) {
              if (isGoingTo == '/login') return null;

              return '/login';
            }

            if (authStatus == AuthStatus.authenticated) {
              if (isGoingTo == '/login') return '/mainlifting';

              return null;
            }

            return null;
          })
    });
