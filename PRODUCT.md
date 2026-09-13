# QR Töleg

QR Töleg is a small mobile utility that makes TMcell balance transfers easier and less error-prone.

The existing TMcell transfer flow requires the sender to manually enter the recipient's phone number into an SMS. QR Töleg replaces that manual number entry with a QR code while leaving the actual transfer under the user's control.

## Core experience

A user enters and confirms their own phone number once. QR Töleg remembers it and creates a personal QR code.

When someone wants to send balance to them:

1. The sender scans the recipient's QR code.
2. QR Töleg extracts and validates the recipient number.
3. The sender enters an amount.
4. QR Töleg shows the recipient, amount, fee, total required balance, and SMS that will be prepared.
5. QR Töleg opens the system messaging app with the transfer SMS filled in.
6. The user reviews it and presses Send themselves.

The returning user's personal QR should be immediately accessible and is the main receiving experience.

## Transfer assumptions

QR Töleg currently assumes the TMcell balance-transfer flow is:

- SMS destination: `0804`
- SMS body: `{recipient-number} {amount}`
- recipient number: exactly 11 ASCII digits beginning with `993`
- transfer amount: whole-number TMT values from `1` through `50`
- carrier fee: `0.10 TMT`
- recipient receives the requested amount

These are product assumptions to be verified on real TMcell devices and changed if actual carrier behavior differs.

## QR format

QR Töleg uses a small versioned payload:

`QRTM1:993XXXXXXXX`

Only this exact format should be accepted as a QR Töleg recipient code.

## Product boundaries

QR Töleg is a helper, not a payment processor.

It does not independently verify that a phone number exists, belongs to TMcell, or belongs to the person showing the QR code. It does not check account balance or determine whether a transfer ultimately succeeds.

It must not automatically send the transfer. The final SMS remains visible to the user and the user presses Send in their normal messaging app.

The core experience should work without a backend, account, cloud service, or internet connection.

The first version should stay deliberately small. Features such as contacts integration, balance checks, transfer history, direct SMS sending, arbitrary QR formats, analytics, ads, and cloud accounts are outside the current scope.

## Product direction

Prefer a simple, understandable experience over adding features or abstractions.

The product is intended primarily for Turkmen users. Development copy may remain in English while the experience is being built; polished Turkmen copy is a release task.

QR Töleg is not an official TMcell application and is not affiliated with TMcell.
