Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id ECDA435EAF3
	for <lists+kvmarm@lfdr.de>; Wed, 14 Apr 2021 04:38:34 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 83D454B74A;
	Tue, 13 Apr 2021 22:38:34 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.21
X-Spam-Level: 
X-Spam-Status: No, score=0.21 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699, FREEMAIL_FROM=0.001,
	HTML_MESSAGE=0.001, RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
	T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@outlook.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iBeYtgBrDhit; Tue, 13 Apr 2021 22:38:34 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 264374B73A;
	Tue, 13 Apr 2021 22:38:33 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 9B32F4B5D1
 for <kvmarm@lists.cs.columbia.edu>; Tue, 13 Apr 2021 22:38:32 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9sfeivJgcSiu for <kvmarm@lists.cs.columbia.edu>;
 Tue, 13 Apr 2021 22:38:31 -0400 (EDT)
Received: from APC01-SG2-obe.outbound.protection.outlook.com
 (mail-oln040092253052.outbound.protection.outlook.com [40.92.253.52])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id CCCCF4B50B
 for <kvmarm@lists.cs.columbia.edu>; Tue, 13 Apr 2021 22:38:30 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gQCI4aaPIIlkw3nX4kp1UOu9Jeh0hIq+jwmSn5mFUOkKg8RiRuIm65vA7A2DkNg8iqmSBmQ1m3pYwACe8hkzNtQn6/dJmF7BVqPnr/13Rv7Ik1kFnHHiUTGvRxUJSZIRtxVZdEqPjfd4n4KePZveKiQCZS8eEY8DnSha68gMBND9+iX14suDCEELG4FECYxIXl82FEyspBhRoXiKC+9KownnIymy3PQVeif26C9Wr8IpE6eK0EAL/hpT2wAk9l3VwzusuRQQ8yLf6I2WWt6y9LTFcJFQM279rwmb+jdWN52YMR7Q7tluIuyjvoSAZjMAh0UszfCUtdmzWnGeyp9Mzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w1xwWzK2p/PpwnTfa9Eh6ZAiQ+Iv7he7CDA4TZUeJtc=;
 b=YetWb4KwzvpttmCfiPSU0bE9l+DnG2SL2+3m9W+fB3Wk/fTt7jZkLogsWC5uZYuKVCaPGIKsT3Qd1KUtGI4HcC5XpSVHCHa+qE6zQQSzf2lsAtWa4jk2U39F+MeNl3TSWdXGOk3KfwDZQf1K/H36tFQlXY2PEHPpXhyu9OGmeiEDSkWCDBQcA7KyBFw3DZtRBy9zIdKWlepX3nK7HpehLoyofCusrkuD98dYrP7HxKKtQHUCP0SN6EyW+R4gnKx2DcSHRfURZsut9RBl8mnvYZUEFMh8ZS6aTZ1VQSsBKVyxpOXQMIdr7kRK1NcMO429nPC4DTk243TEENsrNv3fQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w1xwWzK2p/PpwnTfa9Eh6ZAiQ+Iv7he7CDA4TZUeJtc=;
 b=DzA/jboAJtYgcQZt9pc/eHXMG9cOyzY6McT8pD6gzfHgUxzT+jKV4BYzBlbYewdDd4ijd+q1wfrOLu7hH68oGz/Dz3Tc644fgr+7FQeGrCxtZ4O/dNFN7UdX3AwBaGmyWLX2NovIFpI3FEMY5w5ujzyTOe4kGmO/35EZUlZisWHaReUGAYNYElZhm1bDFnaM0SA2UB6h20cNv3/UpzDrJfeK4/6YlYSB++ffekCu1j2+CJf2iBmuGz1jwzY3U0fYyE3MdbPBtmEPPbqxZ1o4Kn5vwCV9G6RGJ6BZ6c/wiIYkwEqqIrQEdoGZkGn8OkhG9h3mfY6kVKIJdMMI2LdSow==
Received: from PU1APC01FT024.eop-APC01.prod.protection.outlook.com
 (2a01:111:e400:7ebe::42) by
 PU1APC01HT224.eop-APC01.prod.protection.outlook.com (2a01:111:e400:7ebe::482)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17; Wed, 14 Apr
 2021 02:38:16 +0000
Received: from OS0PR01MB5428.jpnprd01.prod.outlook.com
 (2a01:111:e400:7ebe::51) by PU1APC01FT024.mail.protection.outlook.com
 (2a01:111:e400:7ebe::233) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16 via Frontend
 Transport; Wed, 14 Apr 2021 02:38:16 +0000
Received: from OS0PR01MB5428.jpnprd01.prod.outlook.com
 ([fe80::f0f1:9e39:c19e:3e95]) by OS0PR01MB5428.jpnprd01.prod.outlook.com
 ([fe80::f0f1:9e39:c19e:3e95%7]) with mapi id 15.20.4020.023; Wed, 14 Apr 2021
 02:38:16 +0000
From: =?gb2312?B?2Lfo6yCzwg==?= <yinhua_chen@outlook.com>
To: =?gb2312?B?QW5kcqimIFByenl3YXJh?= <andre.przywara@arm.com>,
 "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>
Subject: Re: KVM/ARM64: Booting KVM on FVP/fastmodels
Thread-Topic: KVM/ARM64: Booting KVM on FVP/fastmodels
Thread-Index: AQHXJJQFP+oFOKr+VkCj43E3/+OikqqcVB0AgBcQj62AAACO7w==
Date: Wed, 14 Apr 2021 02:38:16 +0000
Message-ID: <OS0PR01MB5428F21079C6705132ADA89B814E9@OS0PR01MB5428.jpnprd01.prod.outlook.com>
References: <OSYPR01MB54317CECC49E872ACFD9D84B817E9@OSYPR01MB5431.jpnprd01.prod.outlook.com>,
 <0bbea123-7bea-3a2e-70ae-30f43df3000e@arm.com>,
 <OS0PR01MB54283E4CF20EF0D2E423E366814E9@OS0PR01MB5428.jpnprd01.prod.outlook.com>
In-Reply-To: <OS0PR01MB54283E4CF20EF0D2E423E366814E9@OS0PR01MB5428.jpnprd01.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-incomingtopheadermarker: OriginalChecksum:3DD741FFD6DFB80A2D171E164E3AAFF2B5455BB2830B2E0E79CA761F8D0152D7;
 UpperCasedChecksum:B229BC206E7BC84E22F9AEEB3DF35A6D9C000E3F0F409B571CDE3B78F0E65113;
 SizeAsReceived:7076; Count:43
x-tmn: [ekYBTSUQDe2hYHh/pEwtzX7HX1waqMcw]
x-ms-publictraffictype: Email
x-incomingheadercount: 43
x-eopattributedmessage: 0
x-ms-office365-filtering-correlation-id: bd2fe5ae-8b25-4c72-a7e2-08d8feee5b9b
x-ms-traffictypediagnostic: PU1APC01HT224:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wFNByvw9s5703STjYfFzPFN6pavpqpKOm028xjzT0Vye6Ji6hzCOhNDgcMg3QntXM25GWtf+YekkzoU6XmHyVrF3Eea3kDEXJ+EMLVE7JpDzrZXJgZzgSvxYKURibjO2+7XdGysat8IpbsLZjqXobeWXn+8ii/uW/ThuexkZNKIhzf4gEy7sSzHbHdL7rs4W85dAAortx+1/OA5mozkrGHhQyLidUCSH7HHO6KSrlawrCrxj6ijXH5BgtUplLSNjdTLHo7JFA/T5YWch1icjgghyH4tB8gpSq+6k2MvOwsthavNgLl7b6JaR9PmwBtxhbHXFD1/iawjk8zVV9ortKLVS8z6glvuVvz4/+Te5iqvV6he6wdzNt52OrcQL4c1q9Sn4rOKwJQXS+y2yDq92UVw/SsX0mz0PoaJDDoCrqHn038fOv2lh+SI2M1U+0SIN
x-ms-exchange-antispam-messagedata: H/sAFeTEK4Jh/2j1A/DND/XYc5VxQyzlbVxXVlIprqGaiBBysVXYOiJ9oPxex9HGgah0mDKbrbshnOe9yKniy9DQ+OOq5zFDivWGbNNVMElBpV+83ARoVO19HZqj/yZwcqAcv3QTAZl4zxM+QcMjAw==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-AuthSource: PU1APC01FT024.eop-APC01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: bd2fe5ae-8b25-4c72-a7e2-08d8feee5b9b
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2021 02:38:16.5245 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1APC01HT224
X-BeenThere: kvmarm@lists.cs.columbia.edu
X-Mailman-Version: 2.1.14
Precedence: list
List-Id: Where KVM/ARM decisions are made <kvmarm.lists.cs.columbia.edu>
List-Unsubscribe: <https://lists.cs.columbia.edu/mailman/options/kvmarm>,
 <mailto:kvmarm-request@lists.cs.columbia.edu?subject=unsubscribe>
List-Archive: <https://lists.cs.columbia.edu/pipermail/kvmarm>
List-Post: <mailto:kvmarm@lists.cs.columbia.edu>
List-Help: <mailto:kvmarm-request@lists.cs.columbia.edu?subject=help>
List-Subscribe: <https://lists.cs.columbia.edu/mailman/listinfo/kvmarm>,
 <mailto:kvmarm-request@lists.cs.columbia.edu?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1549172399216869739=="
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu

--===============1549172399216869739==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_OS0PR01MB5428F21079C6705132ADA89B814E9OS0PR01MB5428jpnp_"

--_000_OS0PR01MB5428F21079C6705132ADA89B814E9OS0PR01MB5428jpnp_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64

SGksIEFuZHJlDQoNCkRvIHlvdSBtZWFuIHRoYXQgaWYgSSBib290IExpbnV4IG9uIEZWUCwgdGhl
biBJIGNhbiBydW4gS1ZNIG9uIEZWUD8gU2luY2UgS1ZNIGlzIGp1c3QgYSBtb2R1bGUgaW4gTGlu
dXg/DQoNCkNoZWVycywNCllpbmh1YQ0KDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
Xw0KRnJvbToga3ZtYXJtLWJvdW5jZXNAbGlzdHMuY3MuY29sdW1iaWEuZWR1IDxrdm1hcm0tYm91
bmNlc0BsaXN0cy5jcy5jb2x1bWJpYS5lZHU+IG9uIGJlaGFsZiBvZiDYt+jrILPCIDx5aW5odWFf
Y2hlbkBvdXRsb29rLmNvbT4NClNlbnQ6IFdlZG5lc2RheSwgQXByaWwgMTQsIDIwMjEgMTA6MzcN
ClRvOiBBbmRyqKYgUHJ6eXdhcmEgPGFuZHJlLnByenl3YXJhQGFybS5jb20+OyBrdm1hcm1AbGlz
dHMuY3MuY29sdW1iaWEuZWR1IDxrdm1hcm1AbGlzdHMuY3MuY29sdW1iaWEuZWR1Pg0KU3ViamVj
dDogUmU6IEtWTS9BUk02NDogQm9vdGluZyBLVk0gb24gRlZQL2Zhc3Rtb2RlbHMNCg0KSGksIEFu
ZHJlDQoNCkRvIHlvdSBtZWFuIHRoYXQgaWYgSSBib290IExpbnV4IG9uIEZWUCwgdGhlbiBJIGNh
biBydW4gS1ZNIG9uIEZWUD8gU2luY2UgS1ZNIGlzIGp1c3QgYSBtb2R1bGUgaW4gTGludXg/DQoN
CkNoZWVycywNCkFuZHJlDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXw0KRnJvbTog
QW5kcqimIFByenl3YXJhIDxhbmRyZS5wcnp5d2FyYUBhcm0uY29tPg0KU2VudDogVHVlc2RheSwg
TWFyY2ggMzAsIDIwMjEgMTg6MjINClRvOiB5aW5odWFfY2hlbkBvdXRsb29rLmNvbSA8eWluaHVh
X2NoZW5Ab3V0bG9vay5jb20+OyBrdm1hcm1AbGlzdHMuY3MuY29sdW1iaWEuZWR1IDxrdm1hcm1A
bGlzdHMuY3MuY29sdW1iaWEuZWR1Pg0KU3ViamVjdDogUmU6IEtWTS9BUk02NDogQm9vdGluZyBL
Vk0gb24gRlZQL2Zhc3Rtb2RlbHMNCg0KT24gMjkvMDMvMjAyMSAxMzoxMywgeWluaHVhX2NoZW5A
b3V0bG9vay5jb20gd3JvdGU6DQoNCkhpLA0KDQo+IEkgd2FudCB0byBib290IEtWTSBvbiBzaW11
bGF0b3JzLg0KPg0KPiBJIGRvbid0IHdhbnQgdG8gdXNlIFFFTVUgc2luY2Ugc29tZSBmZWF0dXJl
cyBhcmUgb25seSBzdXBwb3J0ZWQgb24NCj4gRlZQL2Zhc3Rtb2RlbHMgbm93Lg0KPg0KPiBIb3dl
dmVyLCBJIGNhbm5vdCBmaW5kIGRvY3VtZW50cy9ibG9ncy93aWtpIGFib3V0IGJvb3RpbmcgS1ZN
IG9uDQo+IEZWUC9mYXN0bW9kZWxzLg0KPg0KPiBEb2VzIEtWTSBzdXBwb3J0IHJ1bm5pbmcgb24g
RlZQPw0KDQpUaGUgRlZQIGVtdWxhdGVzIHRoZSBmdWxsIGFyY2hpdGVjdHVyZSwgaW5jbHVkaW5n
IGFsbCBleGNlcHRpb24gbGV2ZWxzDQooc28gYWxzbyBFTDIpLCBhbmQgdGhlIHZpcnR1YWxpemF0
aW9uIHN1cHBvcnQgb2YgdGhlIEdJQyBhbmQgdGhlIEdlbmVyaWMNClRpbWVyLg0KU28geWVzLCB0
aGUgbW9kZWxzIGZ1bGx5IHN1cHBvcnQgS1ZNIChvciBhbnkgb3RoZXIgaHlwZXJ2aXNvciwgZm9y
IHRoYXQNCm1hdHRlciksIGFuZCBhcmUgaW4gZmFjdCBvZnRlbiB1c2VkIGZvciBkZXZlbG9waW5n
IEtWTSBzdXBwb3J0IG9mIG5ldw0KaGFyZHdhcmUgZmVhdHVyZXMuDQoNClNvIHdoYXQgYXJlIHRo
ZSBwcm9ibGVtcyB0aGF0IHlvdSBhcmUgZmFjaW5nPyBKdXN0IHJ1bm5pbmcgYSBrZXJuZWwgbGlr
ZQ0KeW91IHdvdWxkIG5vcm1hbGx5IGRvIG9uIHRoZSBtb2RlbCBzaG91bGQgd29yayBvdXQgb2Yg
dGhlIGJveC4NCklmIHlvdSBkZXNjcmliZSB5b3VyIHNldHVwIGFuZCB0aGUgZXJyb3IgbWVzc2Fn
ZXMsIHdlIGNhbiBwcm9iYWJseSBoZWxwDQp5b3UgYmV0dGVyLg0KDQpDaGVlcnMsDQpBbmRyZQ0K
DQo+DQo+IEFwcHJlY2lhdGUgZm9yIHlvdXIgaGVscCENCj4NCj4gU2luY2VyZWx5LA0KPiBZaW5o
dWENCj4NCj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18N
Cj4ga3ZtYXJtIG1haWxpbmcgbGlzdA0KPiBrdm1hcm1AbGlzdHMuY3MuY29sdW1iaWEuZWR1DQo+
IGh0dHBzOi8vbGlzdHMuY3MuY29sdW1iaWEuZWR1L21haWxtYW4vbGlzdGluZm8va3ZtYXJtDQo+
DQoNCg==

--_000_OS0PR01MB5428F21079C6705132ADA89B814E9OS0PR01MB5428jpnp_
Content-Type: text/html; charset="gb2312"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dgb2312">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<div style=3D"margin:0px;font-size:15px;font-family:&quot;Segoe UI&quot;, &=
quot;Segoe UI Web (West European)&quot;, &quot;Segoe UI&quot;, -apple-syste=
m, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, sans-serif;color=
:black;background-color:rgb(255, 255, 255)">
<span style=3D"margin:0px;font-size:14.67px;background-color:white">Hi,&nbs=
p;<span style=3D"margin:0px;background-color:white">Andre</span></span><br>
<br>
<span style=3D"margin:0px;font-size:14.67px">Do you mean that if I boot Lin=
ux on FVP, then I can run KVM on FVP? Since KVM is just a module in Linux?<=
/span></div>
<div style=3D"margin:0px;font-size:15px;font-family:&quot;Segoe UI&quot;, &=
quot;Segoe UI Web (West European)&quot;, &quot;Segoe UI&quot;, -apple-syste=
m, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, sans-serif;color=
:black;background-color:rgb(255, 255, 255)">
<br>
<span style=3D"margin:0px;font-size:14.67px;background-color:white">Cheers,=
</span><br>
<span style=3D"margin:0px;font-size:14.67px;background-color:white">Yinhua<=
/span></div>
<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> kvmarm-bounces@lists.=
cs.columbia.edu &lt;kvmarm-bounces@lists.cs.columbia.edu&gt; on behalf of =
=D8=B7=E8=EB =B3=C2 &lt;yinhua_chen@outlook.com&gt;<br>
<b>Sent:</b> Wednesday, April 14, 2021 10:37<br>
<b>To:</b> Andr=A8=A6 Przywara &lt;andre.przywara@arm.com&gt;; kvmarm@lists=
.cs.columbia.edu &lt;kvmarm@lists.cs.columbia.edu&gt;<br>
<b>Subject:</b> Re: KVM/ARM64: Booting KVM on FVP/fastmodels</font>
<div>&nbsp;</div>
</div>
<style type=3D"text/css" style=3D"display:none">
<!--
p
	{margin-top:0;
	margin-bottom:0}
-->
</style>
<div dir=3D"ltr">
<div style=3D"color:rgb(0,0,0)"><span style=3D"font-size:14.6667px; backgro=
und-color:rgb(255,255,255); display:inline!important">Hi,&nbsp;<span style=
=3D"background-color:rgb(255,255,255); display:inline!important">Andre</spa=
n></span><br>
<br style=3D"font-size:14.6667px; background-color:rgb(255,255,255)">
<span style=3D"font-size:14.6667px">Do you mean that if I boot Linux on FVP=
, then I can run KVM on FVP? Since KVM is just a module in Linux?</span></d=
iv>
<div style=3D"color:rgb(0,0,0)"><br style=3D"font-size:14.6667px; backgroun=
d-color:rgb(255,255,255)">
<span style=3D"font-size:14.6667px; background-color:rgb(255,255,255); disp=
lay:inline!important">Cheers,</span><br style=3D"font-size:14.6667px; backg=
round-color:rgb(255,255,255)">
<span style=3D"font-size:14.6667px; background-color:rgb(255,255,255); disp=
lay:inline!important">Andre</span><br>
</div>
<div id=3D"x_appendonsend"></div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" =
color=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Andr=A8=A6 Przywara=
 &lt;andre.przywara@arm.com&gt;<br>
<b>Sent:</b> Tuesday, March 30, 2021 18:22<br>
<b>To:</b> yinhua_chen@outlook.com &lt;yinhua_chen@outlook.com&gt;; kvmarm@=
lists.cs.columbia.edu &lt;kvmarm@lists.cs.columbia.edu&gt;<br>
<b>Subject:</b> Re: KVM/ARM64: Booting KVM on FVP/fastmodels</font>
<div>&nbsp;</div>
</div>
<div class=3D"x_BodyFragment"><font size=3D"2"><span style=3D"font-size:11p=
t">
<div class=3D"x_PlainText">On 29/03/2021 13:13, yinhua_chen@outlook.com wro=
te:<br>
<br>
Hi,<br>
<br>
&gt; I want to boot KVM on simulators.<br>
&gt; <br>
&gt; I don't want to use QEMU since some features are only supported on<br>
&gt; FVP/fastmodels now.<br>
&gt; <br>
&gt; However, I cannot find documents/blogs/wiki about booting KVM on<br>
&gt; FVP/fastmodels.<br>
&gt; <br>
&gt; Does KVM support running on FVP?<br>
<br>
The FVP emulates the full architecture, including all exception levels<br>
(so also EL2), and the virtualization support of the GIC and the Generic<br=
>
Timer.<br>
So yes, the models fully support KVM (or any other hypervisor, for that<br>
matter), and are in fact often used for developing KVM support of new<br>
hardware features.<br>
<br>
So what are the problems that you are facing? Just running a kernel like<br=
>
you would normally do on the model should work out of the box.<br>
If you describe your setup and the error messages, we can probably help<br>
you better.<br>
<br>
Cheers,<br>
Andre<br>
<br>
&gt; <br>
&gt; Appreciate for your help!<br>
&gt; <br>
&gt; Sincerely,<br>
&gt; Yinhua<br>
&gt; <br>
&gt; _______________________________________________<br>
&gt; kvmarm mailing list<br>
&gt; kvmarm@lists.cs.columbia.edu<br>
&gt; <a href=3D"https://lists.cs.columbia.edu/mailman/listinfo/kvmarm">http=
s://lists.cs.columbia.edu/mailman/listinfo/kvmarm</a><br>
&gt; <br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_OS0PR01MB5428F21079C6705132ADA89B814E9OS0PR01MB5428jpnp_--

--===============1549172399216869739==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm

--===============1549172399216869739==--
