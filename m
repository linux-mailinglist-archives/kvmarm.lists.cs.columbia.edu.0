Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id B285435EAF1
	for <lists+kvmarm@lfdr.de>; Wed, 14 Apr 2021 04:37:19 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 24B2E4B7CD;
	Tue, 13 Apr 2021 22:37:19 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.91
X-Spam-Level: 
X-Spam-Status: No, score=0.91 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699, FREEMAIL_FROM=0.001,
	HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
	T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@outlook.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tbWe+SfaJIPl; Tue, 13 Apr 2021 22:37:18 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id D0C604B660;
	Tue, 13 Apr 2021 22:37:17 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id AD2F94B50B
 for <kvmarm@lists.cs.columbia.edu>; Tue, 13 Apr 2021 22:37:15 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5BZYuE0TbIUW for <kvmarm@lists.cs.columbia.edu>;
 Tue, 13 Apr 2021 22:37:13 -0400 (EDT)
Received: from APC01-PU1-obe.outbound.protection.outlook.com
 (mail-oln040092254022.outbound.protection.outlook.com [40.92.254.22])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 0271D4B5D1
 for <kvmarm@lists.cs.columbia.edu>; Tue, 13 Apr 2021 22:37:12 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JZU7E6deeIElC171lS7YF7t2tERrttzaIlqZKixWK3pL6hDSS4fLUp4ugZ8h261FcSE66mgWHgb/1SsUm28u6bK4uRnzk9+bHDYIzMh5nwZcaYXqPx3Z8hDa28zrhoqMlpl5l3/zK//jaaSPg53R/7exNwKIarNBnSqAbj1nq9HJGihabHpqrSc4HIDAtLLg0K589xpA2xKHOQHb8jBPN16YQFMplNdImjbreqDLMCjzIiayz+VG7YSYnN9zxSBHVQJ7R4ozh+oU/ShvWtPsMZsAIn40/nOgPhNTMCBtnbYti65EOkhaB3+bycICbqu1SV6OnxCkM6Of/oYiHLvPIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CY3pEXSgJzZfNg/U2hUzM3eVP7KFOL5wRXhMEXk53cY=;
 b=IoYWUVoBOwTMRdMlbc9RLVhNg3HOWeI7cZhEuz0pd0oMOiXSedA67tOKL8hOuguOmnjXofrJrg2IVkjwCxJ/7y3dSsEmkGuaosYf3oiyHfIauIxCdlb34WJBAeDhsIkB0ve7jLwRZUnSFiuXzPrh2TVEeSA4Uvzm5YBg2NPwokqLBaTmMdoHsZlIPjZ5/fO0yFahyQmq2ilnPFVbKItwtjkKU5XVljT3S7yvSoWEizUeJBvIw8VsJsQ3g1ia8p2EIZQksBA8CrZpKJe9Sqv4GD6dAeSni3YXFZHTp9Y6EmLoob4+Zpksw6foe5Z+BWW9x4j3LuNfYqd+18ooElcYsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CY3pEXSgJzZfNg/U2hUzM3eVP7KFOL5wRXhMEXk53cY=;
 b=nhabIYZW0E4gtQs42mTVzNiRdI+WK2YNiHzBIGfSWVs+diq5VAim+sSMYw0G601BtmmGemzo6qLwc7YkMHooAULJDHE6ZCkqDHW16XV/F5blB8KMsie2o557a7GPpJyTUndpJJriwSQYv+yzyTaU6EuKRDQeFzAI9/WFFgXP4CguEjfxoyg5HzicoVdFg7hesTXsInkVWFoMIof7PsdPgM3BEbZGCHWy6JV1UmH2fKuKBTfAA+mCA9nRWlyYeCdYW6xR+jU2TDJJbYm2kAH3pGkqqy6qPhOy6Badjgmx76kIfFg0y6t+YcOXxJdxK5f3IpdWmuhqhNoIXv7tff1WMw==
Received: from PU1APC01FT024.eop-APC01.prod.protection.outlook.com
 (2a01:111:e400:7ebe::43) by
 PU1APC01HT027.eop-APC01.prod.protection.outlook.com (2a01:111:e400:7ebe::324)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17; Wed, 14 Apr
 2021 02:37:08 +0000
Received: from OS0PR01MB5428.jpnprd01.prod.outlook.com
 (2a01:111:e400:7ebe::51) by PU1APC01FT024.mail.protection.outlook.com
 (2a01:111:e400:7ebe::233) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16 via Frontend
 Transport; Wed, 14 Apr 2021 02:37:08 +0000
Received: from OS0PR01MB5428.jpnprd01.prod.outlook.com
 ([fe80::f0f1:9e39:c19e:3e95]) by OS0PR01MB5428.jpnprd01.prod.outlook.com
 ([fe80::f0f1:9e39:c19e:3e95%7]) with mapi id 15.20.4020.023; Wed, 14 Apr 2021
 02:37:07 +0000
From: =?gb2312?B?2Lfo6yCzwg==?= <yinhua_chen@outlook.com>
To: =?gb2312?B?QW5kcqimIFByenl3YXJh?= <andre.przywara@arm.com>,
 "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>
Subject: Re: KVM/ARM64: Booting KVM on FVP/fastmodels
Thread-Topic: KVM/ARM64: Booting KVM on FVP/fastmodels
Thread-Index: AQHXJJQFP+oFOKr+VkCj43E3/+OikqqcVB0AgBcQj60=
Date: Wed, 14 Apr 2021 02:37:07 +0000
Message-ID: <OS0PR01MB54283E4CF20EF0D2E423E366814E9@OS0PR01MB5428.jpnprd01.prod.outlook.com>
References: <OSYPR01MB54317CECC49E872ACFD9D84B817E9@OSYPR01MB5431.jpnprd01.prod.outlook.com>,
 <0bbea123-7bea-3a2e-70ae-30f43df3000e@arm.com>
In-Reply-To: <0bbea123-7bea-3a2e-70ae-30f43df3000e@arm.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-incomingtopheadermarker: OriginalChecksum:E9D69F7DCE0F513C32549B6C434ADD96FBB53AE3C512AFCB2649973F8E6E802D;
 UpperCasedChecksum:707AB82452DDE303F1FF71D56F08E9C33A0DEFFAF6A70643180A08307370CEB0;
 SizeAsReceived:6956; Count:43
x-tmn: [+XiYd+TNWNOsYEEZsd1fHsrbTXjhJ+Zv]
x-ms-publictraffictype: Email
x-incomingheadercount: 43
x-eopattributedmessage: 0
x-ms-office365-filtering-correlation-id: 3eed98c4-b457-4a3b-1ac4-08d8feee326a
x-ms-traffictypediagnostic: PU1APC01HT027:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Xdd7QjM2UkPlDvLJqQtG6M1SJOlVzhHsYn22tT7wVS/iIizgoyII5nwd+/keU6/CZOsZVcM5/mf4My6ZGgynaVa7xFEkNnzNKhTJRgubx5XP/riiTIL/BZ53v3bn82HIPOEq9o+KhRDMo/0Dg4mL29wPUtmaOXSypWY8y41QDvJ0x4s1kX54X9vpiZtmjX1rLHevCDph5Ve0iYgJFyoi98YoB60D8lydDpT++DODrqPGtsP28xxuLsrVRVGo7tVraDqthhKK0M0YJhVlPrWgPMw0Il5V0HL6a0LwoQyByRtggVKFY41ADqmk+fVEyVvHgPGqvG+dkvwr3PF0t14a+VqQrTnvQkC48KnzevyFxip2FZ8fDWyVuEVpx8mdRAwlwsHtrOrJsXIgqDghWc1LoSzaA8ylQxto+lfkvm1dAJU1IL/AksO3rXHYbef0qpFY
x-ms-exchange-antispam-messagedata: mpBTgfRoM4+XG0yACxACNVbf2f+QrMKcqgFDRTp6Ei4IHRjQVI6l17+Y2vQ3dH656gOUjXrelxA21QjYNWaaiHE2S4G4dnMpgcQNmnnrMeqVsAC5jWTTCaOd28snksT2Ohn9SX9Xz3KjKJPmBJx71A==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-AuthSource: PU1APC01FT024.eop-APC01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 3eed98c4-b457-4a3b-1ac4-08d8feee326a
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2021 02:37:07.3644 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1APC01HT027
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
Content-Type: multipart/mixed; boundary="===============3901041517377315795=="
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu

--===============3901041517377315795==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_OS0PR01MB54283E4CF20EF0D2E423E366814E9OS0PR01MB5428jpnp_"

--_000_OS0PR01MB54283E4CF20EF0D2E423E366814E9OS0PR01MB5428jpnp_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64

SGksIEFuZHJlDQoNCkRvIHlvdSBtZWFuIHRoYXQgaWYgSSBib290IExpbnV4IG9uIEZWUCwgdGhl
biBJIGNhbiBydW4gS1ZNIG9uIEZWUD8gU2luY2UgS1ZNIGlzIGp1c3QgYSBtb2R1bGUgaW4gTGlu
dXg/DQoNCkNoZWVycywNCkFuZHJlDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXw0K
RnJvbTogQW5kcqimIFByenl3YXJhIDxhbmRyZS5wcnp5d2FyYUBhcm0uY29tPg0KU2VudDogVHVl
c2RheSwgTWFyY2ggMzAsIDIwMjEgMTg6MjINClRvOiB5aW5odWFfY2hlbkBvdXRsb29rLmNvbSA8
eWluaHVhX2NoZW5Ab3V0bG9vay5jb20+OyBrdm1hcm1AbGlzdHMuY3MuY29sdW1iaWEuZWR1IDxr
dm1hcm1AbGlzdHMuY3MuY29sdW1iaWEuZWR1Pg0KU3ViamVjdDogUmU6IEtWTS9BUk02NDogQm9v
dGluZyBLVk0gb24gRlZQL2Zhc3Rtb2RlbHMNCg0KT24gMjkvMDMvMjAyMSAxMzoxMywgeWluaHVh
X2NoZW5Ab3V0bG9vay5jb20gd3JvdGU6DQoNCkhpLA0KDQo+IEkgd2FudCB0byBib290IEtWTSBv
biBzaW11bGF0b3JzLg0KPg0KPiBJIGRvbid0IHdhbnQgdG8gdXNlIFFFTVUgc2luY2Ugc29tZSBm
ZWF0dXJlcyBhcmUgb25seSBzdXBwb3J0ZWQgb24NCj4gRlZQL2Zhc3Rtb2RlbHMgbm93Lg0KPg0K
PiBIb3dldmVyLCBJIGNhbm5vdCBmaW5kIGRvY3VtZW50cy9ibG9ncy93aWtpIGFib3V0IGJvb3Rp
bmcgS1ZNIG9uDQo+IEZWUC9mYXN0bW9kZWxzLg0KPg0KPiBEb2VzIEtWTSBzdXBwb3J0IHJ1bm5p
bmcgb24gRlZQPw0KDQpUaGUgRlZQIGVtdWxhdGVzIHRoZSBmdWxsIGFyY2hpdGVjdHVyZSwgaW5j
bHVkaW5nIGFsbCBleGNlcHRpb24gbGV2ZWxzDQooc28gYWxzbyBFTDIpLCBhbmQgdGhlIHZpcnR1
YWxpemF0aW9uIHN1cHBvcnQgb2YgdGhlIEdJQyBhbmQgdGhlIEdlbmVyaWMNClRpbWVyLg0KU28g
eWVzLCB0aGUgbW9kZWxzIGZ1bGx5IHN1cHBvcnQgS1ZNIChvciBhbnkgb3RoZXIgaHlwZXJ2aXNv
ciwgZm9yIHRoYXQNCm1hdHRlciksIGFuZCBhcmUgaW4gZmFjdCBvZnRlbiB1c2VkIGZvciBkZXZl
bG9waW5nIEtWTSBzdXBwb3J0IG9mIG5ldw0KaGFyZHdhcmUgZmVhdHVyZXMuDQoNClNvIHdoYXQg
YXJlIHRoZSBwcm9ibGVtcyB0aGF0IHlvdSBhcmUgZmFjaW5nPyBKdXN0IHJ1bm5pbmcgYSBrZXJu
ZWwgbGlrZQ0KeW91IHdvdWxkIG5vcm1hbGx5IGRvIG9uIHRoZSBtb2RlbCBzaG91bGQgd29yayBv
dXQgb2YgdGhlIGJveC4NCklmIHlvdSBkZXNjcmliZSB5b3VyIHNldHVwIGFuZCB0aGUgZXJyb3Ig
bWVzc2FnZXMsIHdlIGNhbiBwcm9iYWJseSBoZWxwDQp5b3UgYmV0dGVyLg0KDQpDaGVlcnMsDQpB
bmRyZQ0KDQo+DQo+IEFwcHJlY2lhdGUgZm9yIHlvdXIgaGVscCENCj4NCj4gU2luY2VyZWx5LA0K
PiBZaW5odWENCj4NCj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18NCj4ga3ZtYXJtIG1haWxpbmcgbGlzdA0KPiBrdm1hcm1AbGlzdHMuY3MuY29sdW1iaWEu
ZWR1DQo+IGh0dHBzOi8vbGlzdHMuY3MuY29sdW1iaWEuZWR1L21haWxtYW4vbGlzdGluZm8va3Zt
YXJtDQo+DQoNCg==

--_000_OS0PR01MB54283E4CF20EF0D2E423E366814E9OS0PR01MB5428jpnp_
Content-Type: text/html; charset="gb2312"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dgb2312">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"color: rgb(0, 0, 0);"><span style=3D"font-family: &quot;Segoe=
 UI&quot;, &quot;Segoe UI Web (West European)&quot;, &quot;Segoe UI&quot;, =
-apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, sans=
-serif; font-size: 14.6667px; background-color: rgb(255, 255, 255); display=
: inline !important;">Hi,&nbsp;<span style=3D"background-color:rgb(255, 255=
, 255);display:inline !important">Andre</span></span><br>
<br style=3D"font-family:&quot;Segoe UI&quot;, &quot;Segoe UI Web (West Eur=
opean)&quot;, &quot;Segoe UI&quot;, -apple-system, BlinkMacSystemFont, Robo=
to, &quot;Helvetica Neue&quot;, sans-serif;font-size:14.6667px;background-c=
olor:rgb(255, 255, 255)">
<span style=3D"font-size: 14.6667px;">Do you mean that if I boot Linux on F=
VP, then I can run KVM on FVP? Since KVM is just a module in Linux?</span><=
/div>
<div style=3D"color: rgb(0, 0, 0);"><br style=3D"font-family:&quot;Segoe UI=
&quot;, &quot;Segoe UI Web (West European)&quot;, &quot;Segoe UI&quot;, -ap=
ple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, sans-se=
rif;font-size:14.6667px;background-color:rgb(255, 255, 255)">
<span style=3D"font-family: &quot;Segoe UI&quot;, &quot;Segoe UI Web (West =
European)&quot;, &quot;Segoe UI&quot;, -apple-system, BlinkMacSystemFont, R=
oboto, &quot;Helvetica Neue&quot;, sans-serif; font-size: 14.6667px; backgr=
ound-color: rgb(255, 255, 255); display: inline !important;">Cheers,</span>=
<br style=3D"font-family:&quot;Segoe UI&quot;, &quot;Segoe UI Web (West Eur=
opean)&quot;, &quot;Segoe UI&quot;, -apple-system, BlinkMacSystemFont, Robo=
to, &quot;Helvetica Neue&quot;, sans-serif;font-size:14.6667px;background-c=
olor:rgb(255, 255, 255)">
<span style=3D"font-family: &quot;Segoe UI&quot;, &quot;Segoe UI Web (West =
European)&quot;, &quot;Segoe UI&quot;, -apple-system, BlinkMacSystemFont, R=
oboto, &quot;Helvetica Neue&quot;, sans-serif; font-size: 14.6667px; backgr=
ound-color: rgb(255, 255, 255); display: inline !important;">Andre</span><b=
r>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Andr=A8=A6 Przywara &=
lt;andre.przywara@arm.com&gt;<br>
<b>Sent:</b> Tuesday, March 30, 2021 18:22<br>
<b>To:</b> yinhua_chen@outlook.com &lt;yinhua_chen@outlook.com&gt;; kvmarm@=
lists.cs.columbia.edu &lt;kvmarm@lists.cs.columbia.edu&gt;<br>
<b>Subject:</b> Re: KVM/ARM64: Booting KVM on FVP/fastmodels</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">On 29/03/2021 13:13, yinhua_chen@outlook.com wrote=
:<br>
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
</body>
</html>

--_000_OS0PR01MB54283E4CF20EF0D2E423E366814E9OS0PR01MB5428jpnp_--

--===============3901041517377315795==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm

--===============3901041517377315795==--
