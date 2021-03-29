Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id D802B34D550
	for <lists+kvmarm@lfdr.de>; Mon, 29 Mar 2021 18:44:14 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 689D44B21C;
	Mon, 29 Mar 2021 12:44:14 -0400 (EDT)
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
	with ESMTP id vtECoteODWOa; Mon, 29 Mar 2021 12:44:14 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 693B44B227;
	Mon, 29 Mar 2021 12:44:11 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 663A04B1B9
 for <kvmarm@lists.cs.columbia.edu>; Mon, 29 Mar 2021 08:13:15 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3YhnkKxdSuyi for <kvmarm@lists.cs.columbia.edu>;
 Mon, 29 Mar 2021 08:13:13 -0400 (EDT)
Received: from APC01-SG2-obe.outbound.protection.outlook.com
 (mail-oln040092253105.outbound.protection.outlook.com [40.92.253.105])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id B1EF14B1B2
 for <kvmarm@lists.cs.columbia.edu>; Mon, 29 Mar 2021 08:13:12 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z3Z5JCpToWKvER/TYyZSYT8ORlngUbdPsP64eR1p4RqJAVD9EovB8Asm/k5uoavsTUkZaAS6TJZsCxHsX+IXrT9SHYMtcnd6pYUoPCjni5AZoYE38uqGJU3JxsIIF2u8AKpEhFg+vNVP4fg3n3awByVTmfWVQltwuZmI0HfOVLe91AM7OYwcr32VFjIhg0PuArcbt3nMFP0a2JzauEV0d5BFGdaVl9np3WXETWSdOLrljzQFyjNT9bTuYUaed5QwNqGo4Cg0d49XjfZN0gD8Yqd0RKuYOFNkil0cob5cibvmjOI+5mBwCbZL/gsulzWPtJTb6OnQM5CsMqVzoUn8Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KU4MFSWcbZGk3xegyvmT/r2pFYX42TFdFEqq52PjKjU=;
 b=NrHyFIqCyl650DAr4mKnDbhILLBa5t4+rMCNeVfR+XtFAqxdyjwXlcKXQoNnbh6XKu0Ss9ENmuBvhhkLuOwBSr2mefeSiQf8ts+gPVGGfhLXiKXWALe8UTy2w2DNiMY5Qpqt5S5qFPJug2wxcX00Nvdl6r2gl+rxnfEeWhHX1fIIavEHsqhhQV3pKVwh/TfzJww+vQRqTtuEq4PP2WLzTjPg0EsfcH1t5cto1AAbYWkrEXT4kiOfoSAU3DHhCtKHYo2UKE4di1u4UZ3Oi6+KyrAvdEJztCJTB1NUd0cVVjLHaYNTBpuDj2lyqoy4VbeB7faLZ7G1VG2rlbVIjPN9hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KU4MFSWcbZGk3xegyvmT/r2pFYX42TFdFEqq52PjKjU=;
 b=ka3fctOqPBd5/gDSBLNMMRzfKA4s3tjtf1fnrKmL/PJV/wfxgM35B4yn1CMDHOvKCWkJqTrxj1vCMW2ajSJ/ilPOhSsXvxxfbo9Raz2R1M5KZDBQeP9NIVJvMKekmGWY8dL4Y7Wu1Krms1jFGd6owjRIFqO7cB8lgvwv9DBMujoBiAs/e9uVBeYdRIKj5Jetkq60IH+iZ0Uv1sMS1SN74LzdWP9n0VLTzJNHNkRdRrGjn1c8mbJet6uv1RIuY33IsRc6iieM15yfbB1A1hOJmxhqq15qJqejoFvsP8icEk8xcsZRQEGiN/SvhTIYHsc/1M2RRHNYLnXwskLvKIeIlQ==
Received: from PU1APC01FT043.eop-APC01.prod.protection.outlook.com
 (2a01:111:e400:7ebe::40) by
 PU1APC01HT013.eop-APC01.prod.protection.outlook.com (2a01:111:e400:7ebe::65)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25; Mon, 29 Mar
 2021 12:13:01 +0000
Received: from OSYPR01MB5431.jpnprd01.prod.outlook.com (10.152.252.59) by
 PU1APC01FT043.mail.protection.outlook.com (10.152.253.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3977.25 via Frontend Transport; Mon, 29 Mar 2021 12:13:01 +0000
Received: from OSYPR01MB5431.jpnprd01.prod.outlook.com
 ([fe80::311c:8bb5:d1b7:6743]) by OSYPR01MB5431.jpnprd01.prod.outlook.com
 ([fe80::311c:8bb5:d1b7:6743%7]) with mapi id 15.20.3977.033; Mon, 29 Mar 2021
 12:13:00 +0000
From: "yinhua_chen@outlook.com" <yinhua_chen@outlook.com>
To: "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>
Subject: KVM/ARM64: Booting KVM on FVP/fastmodels
Thread-Topic: KVM/ARM64: Booting KVM on FVP/fastmodels
Thread-Index: AQHXJJQFP+oFOKr+VkCj43E3/+Oikg==
Date: Mon, 29 Mar 2021 12:13:00 +0000
Message-ID: <OSYPR01MB54317CECC49E872ACFD9D84B817E9@OSYPR01MB5431.jpnprd01.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-incomingtopheadermarker: OriginalChecksum:3CCFFEC9C03829A1B9A57CD4EE1100DA74F5A689C37FEE097E8FF268F9AC81AF;
 UpperCasedChecksum:084A7D196BED8999C5D84F371217FB2B201E856360704533567B798BFCD6A88C;
 SizeAsReceived:6677; Count:41
x-tmn: [z0d1NzDJMPJ/x0AHfGzDVvfM9seGZgfQ]
x-ms-publictraffictype: Email
x-incomingheadercount: 41
x-eopattributedmessage: 0
x-ms-office365-filtering-correlation-id: 5b00aee6-788c-48c3-14da-08d8f2abff10
x-ms-traffictypediagnostic: PU1APC01HT013:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KeKkNkrqNHbxRBZ7NULor9QEggLcm6eUMhBQ9gIkRDcwr+tb/6V1po7cdu1KCSIZhSkX3Gt6kzGI4ELli/6yyo3LjkMrcJNJp3OY6e7mXGa2trEnjKmYXaZAPjp+PaMY7GUVZF5yThXnPNhlqqtC4ric+9JC9xUv4JjkodLGxngW+F6Q7sezzmk7V6wklxRdK7DCeYndraGBW0JuCdibfOrVPQhUl/5vaFVfJ0gVWCDgcmrDSubHdaMvvytD61kLuMhoIBmfQxRIs1/o7SOd1A/mdw/iXUaq1HcRcpIaED2VdtLo7rbrtOaryB+DBnF8K5JL65USGpMTNr9mf7mm6ec6FswbwJ/JQXo6VwRFr0BdiuoyyhiN/+iMVuMnCE2ELd1+2q31j/Ae7owirkFoGw==
x-ms-exchange-antispam-messagedata: PFs9oCqxgjZlp7wScfGwiH990texBW8ihOutaezZIENYuZkpk80ZvO6cg8D2qWYVRDzqglbUUDqfrWIXugI/ltG1Pwmlm9mnc5YUCqpcJNaNcXTzVurnKQL8bH4RB3Vgr5TIs3/m/cNpaGapn3K3KQ==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-AuthSource: PU1APC01FT043.eop-APC01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b00aee6-788c-48c3-14da-08d8f2abff10
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2021 12:13:00.4194 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1APC01HT013
X-Mailman-Approved-At: Mon, 29 Mar 2021 12:44:10 -0400
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
Content-Type: multipart/mixed; boundary="===============4319457985670139477=="
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu

--===============4319457985670139477==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_OSYPR01MB54317CECC49E872ACFD9D84B817E9OSYPR01MB5431jpnp_"

--_000_OSYPR01MB54317CECC49E872ACFD9D84B817E9OSYPR01MB5431jpnp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi all,

I want to boot KVM on simulators.

I don't want to use QEMU since some features are only supported on FVP/fast=
models now.

However, I cannot find documents/blogs/wiki about booting KVM on FVP/fastmo=
dels.

Does KVM support running on FVP?

Appreciate for your help!

Sincerely,
Yinhua

--_000_OSYPR01MB54317CECC49E872ACFD9D84B817E9OSYPR01MB5431jpnp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Hi all,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
I want to boot KVM on simulators.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
I don't want to use QEMU since some features are only supported on FVP/fast=
models now.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
However, I cannot find documents/blogs/wiki about booting KVM on FVP/fastmo=
dels.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Does KVM support running on FVP?</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Appreciate for your help!</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Sincerely,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Yinhua</div>
</body>
</html>

--_000_OSYPR01MB54317CECC49E872ACFD9D84B817E9OSYPR01MB5431jpnp_--

--===============4319457985670139477==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm

--===============4319457985670139477==--
