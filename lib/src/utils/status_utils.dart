import 'package:flutter/material.dart';
import 'package:iop_sdk/authority.dart';

class StatusUtils {
  static String asText(Status status) {
    switch(status) {
      case Status.pending:
        return 'pending';
      case Status.approved:
        return 'approved';
      case Status.rejected:
        return 'rejected';
      default:
        return '?';
    }
  }

  static Icon buildIcon(Status status) {
    switch (status) {
      case Status.approved:
        return const Icon(Icons.check, color: Colors.green);
      case Status.pending:
        return const Icon(Icons.hourglass_bottom, color: Colors.amber);
      case Status.rejected:
        return const Icon(Icons.close, color: Colors.red);
    }
  }
}