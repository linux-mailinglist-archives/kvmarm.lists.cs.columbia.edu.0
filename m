Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id ADFCF34E4EA
	for <lists+kvmarm@lfdr.de>; Tue, 30 Mar 2021 11:58:35 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 41AA04B2E7;
	Tue, 30 Mar 2021 05:58:35 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.209
X-Spam-Level: 
X-Spam-Status: No, score=0.209 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_LOW=-0.7,
	SPF_HELO_PASS=-0.001, T_DKIM_INVALID=0.01, UNPARSEABLE_RELAY=0.001]
	autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, body has been altered) header.i=@armh.onmicrosoft.com
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, body has been altered) header.i=@armh.onmicrosoft.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MTTktDpa0NUb; Tue, 30 Mar 2021 05:58:35 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 8F4764B2DA;
	Tue, 30 Mar 2021 05:58:33 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id F0B4A4B2B7
 for <kvmarm@lists.cs.columbia.edu>; Tue, 30 Mar 2021 05:58:31 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iEAYR8qPURxY for <kvmarm@lists.cs.columbia.edu>;
 Tue, 30 Mar 2021 05:58:30 -0400 (EDT)
Received: from EUR02-VE1-obe.outbound.protection.outlook.com
 (mail-eopbgr20078.outbound.protection.outlook.com [40.107.2.78])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id D24644B28D
 for <kvmarm@lists.cs.columbia.edu>; Tue, 30 Mar 2021 05:58:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com; 
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dwztw6OGL1OGLxR4jjcllN+v2zmJ+78Qf6FuisRjnQs=;
 b=J1RCznGIVG/qJ6++19u+Sywo0hfIlwnjhxJBK4lNrOQqaZIamWU5YzGug1QnQmXdzd/T5bH248MKj/n08tglPfsSf3ZfZzWiTHTXVwXVAuylKsOkMwmpZMvMS7wdP9x9pt/wwbU7cJKshyvokUax+zn2SWvk6YDXtzhPGqRChyQ=
Received: from AM6PR0502CA0040.eurprd05.prod.outlook.com
 (2603:10a6:20b:56::17) by AM8PR08MB5857.eurprd08.prod.outlook.com
 (2603:10a6:20b:1d2::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24; Tue, 30 Mar
 2021 09:58:25 +0000
Received: from AM5EUR03FT017.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:20b:56:cafe::ba) by AM6PR0502CA0040.outlook.office365.com
 (2603:10a6:20b:56::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24 via Frontend
 Transport; Tue, 30 Mar 2021 09:58:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; lists.cs.columbia.edu; dkim=pass (signature was
 verified) header.d=armh.onmicrosoft.com;lists.cs.columbia.edu; dmarc=pass
 action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT017.mail.protection.outlook.com (10.152.16.89) with
 Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3977.25 via Frontend Transport; Tue, 30 Mar 2021 09:58:24 +0000
Received: ("Tessian outbound 6484dad39064:v89");
 Tue, 30 Mar 2021 09:58:24 +0000
X-CR-MTA-TID: 64aa7808
Received: from d27e47a27201.2
 by 64aa7808-outbound-1.mta.getcheckrecipient.com id
 9CB92BF5-0004-43F8-8AB8-E1770253CA32.1; 
 Tue, 30 Mar 2021 09:58:13 +0000
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id d27e47a27201.2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
 Tue, 30 Mar 2021 09:58:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fg5i10ZnEjf6xNhG8qoGY8HvQFK4WICASvcd5YJ/YTYVX2lxFmBsO6A9TDIsOG8asknDWBVQNa8xwyV6yy0FVhUYIehD6oT+llpGuUKGJfaIh2fPCInJ7DP4B9PqTDglb2mhk5f2cJaHSL2wB9bT0UITFeTd1w28gVsHwd5IZoHT7f+jrEfIl3p/Jo11eYeRygefTQ4p9AmXB8QyunspKTdO2oBG4wlxw+Bppv12f4oS3uyWnBBcqRTVridCFJE6rcbszMyH0qrwJsMMXzdK8HbfmA84b9F5zTlICnIipcT26hNmN+OztDSQRxOGCByYTfU62qbYBdd2BcaNVStCBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dwztw6OGL1OGLxR4jjcllN+v2zmJ+78Qf6FuisRjnQs=;
 b=KzI1yU8LTdtbJkG+gdColE1eanB5Gz6ffFA9z1dPzzX1UHMEUsq1qzbaCze99kJ/ZVvaw3uNWsU7b9RUJbXEWiXilNTrBoaJOj6nck+mh4vN66CNTC14kcvNwZOL+rIdcxPEmtHn0zgM73b7qiOppdygmrDQDGumbWjyj/XBwRyGa7LIbVCQyN83Wf4l52yKAjCdlc061NziJoGnmFFyxATo0G85AxyfTc+usbNcnlpP1QqFRUs6mbmCT0CwowuQnSFDOHqK6f9rCB+Ps50FRQZjzgfN9I4153ssufkhzxMQaw8PhtgusVsKWt8FD4s7efBGJi6aqgUBy0adoHdgyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com; 
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dwztw6OGL1OGLxR4jjcllN+v2zmJ+78Qf6FuisRjnQs=;
 b=J1RCznGIVG/qJ6++19u+Sywo0hfIlwnjhxJBK4lNrOQqaZIamWU5YzGug1QnQmXdzd/T5bH248MKj/n08tglPfsSf3ZfZzWiTHTXVwXVAuylKsOkMwmpZMvMS7wdP9x9pt/wwbU7cJKshyvokUax+zn2SWvk6YDXtzhPGqRChyQ=
Received: from AM5PR0801MB2082.eurprd08.prod.outlook.com (2603:10a6:203:4b::8)
 by AM6PR08MB4456.eurprd08.prod.outlook.com (2603:10a6:20b:b3::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.31; Tue, 30 Mar
 2021 09:58:10 +0000
Received: from AM5PR0801MB2082.eurprd08.prod.outlook.com
 ([fe80::d1cf:ab3c:b570:fecd]) by AM5PR0801MB2082.eurprd08.prod.outlook.com
 ([fe80::d1cf:ab3c:b570:fecd%6]) with mapi id 15.20.3977.033; Tue, 30 Mar 2021
 09:58:09 +0000
From: Jianyong Wu <Jianyong.Wu@arm.com>
To: Marc Zyngier <maz@kernel.org>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "yangbo.lu@nxp.com" <yangbo.lu@nxp.com>,
 "john.stultz@linaro.org" <john.stultz@linaro.org>, "tglx@linutronix.de"
 <tglx@linutronix.de>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "seanjc@google.com" <seanjc@google.com>, "richardcochran@gmail.com"
 <richardcochran@gmail.com>, Mark Rutland <Mark.Rutland@arm.com>,
 "will@kernel.org" <will@kernel.org>, Suzuki Poulose <Suzuki.Poulose@arm.com>, 
 Andre Przywara <Andre.Przywara@arm.com>, Steven Price <Steven.Price@arm.com>, 
 Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Sudeep Holla
 <Sudeep.Holla@arm.com>
Subject: RE: [PATCH v18 6/7] KVM: arm64: Add support for the KVM PTP service
Thread-Topic: [PATCH v18 6/7] KVM: arm64: Add support for the KVM PTP service
Thread-Index: AQHW/iATKjeo8cqNVEyhiuLiVP2EbqqcmfVw
Date: Tue, 30 Mar 2021 09:58:08 +0000
Message-ID: <AM5PR0801MB20828444C832DBC6845D742BF47D9@AM5PR0801MB2082.eurprd08.prod.outlook.com>
References: <20210208134029.3269384-1-maz@kernel.org>
 <20210208134029.3269384-7-maz@kernel.org>
In-Reply-To: <20210208134029.3269384-7-maz@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ts-tracking-id: E9FB7ABCDDFDFA4D97756F72705BFE12.0
x-checkrecipientchecked: true
Authentication-Results-Original: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=arm.com;
x-originating-ip: [203.126.0.112]
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5f388d03-394e-40a5-7c96-08d8f3625bed
x-ms-traffictypediagnostic: AM6PR08MB4456:|AM8PR08MB5857:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <AM8PR08MB585703D5ED0ED94F0A2E47CBF47D9@AM8PR08MB5857.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
nodisclaimer: true
x-ms-oob-tlc-oobclassifiers: OLM:2276;OLM:2276;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: GhTR3Xwjmw7/ZHsHWip9nFbsJT6CGA9V9eSjKCGH+akn1Y3f5Qfb4ObRmIEVxP8AU37AqbveZOxpknDW2J4+zCxC9WLgjiZ0mRg6ijdPcMJxBzTLliY1hpsElX94ej1/mZYcvfn86+ypVnknVCgJPOg1uV4OTHlvlYdT/W4VoEORjqwfHWs/7gKnPCV4DxgtSgBPyQBm3IfMnyS/bYn/WNqjCKYxwFrPfypTnhD5Wzx0yUHselkk+JPT6WYQ308h7YK5YdS2+Y9oEVjGJljCzeVyELk9rZKW8AZ6YXFe+F4bV/egRnC+M9LvxWUHM7cz5Fr6T9+rg7t+1lzIz5uoHKRQzlsrnSzF6OVNJwmILHyUQojsgtGfBwsA18K0D3kIKoU02ScERv9DeTbRDRmGABv+Rzj5fp16zFr1uXLmTb+mljFPDjrqoAMYJRPC4dd+1pxvL1r1RDbxnjY/0RdKnTKgZxoxPsJREabLI2Qk3Lv/wISIUwCpf6B4uP1FvINNOVPQnKLMIIsz3qcPPL7EW95MlgJz1mP6p9jBqm1+qATIVjtgRXkmVVedsBMbFteX0SVBeOTXg2zdbrar6fFSFA4SX/4TrZ52SDqwRe3dMpaADrx/EVzwBFeHsI/d8VfZqTY46Mltk5Ogoz35fo0MYpxQWozyUrsBRDYSFIJJ2Hd8GJI/Kno5xdvP3zu55LRtGWnWNpYaN00aRPzZsL2NX85k9o5XHm6nG1TBldOMIZXJkjFldM5GrTE9IZqff3Ly
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM5PR0801MB2082.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(4636009)(346002)(396003)(366004)(39850400004)(376002)(136003)(66556008)(38100700001)(52536014)(9686003)(66946007)(5660300002)(8676002)(8936002)(55016002)(26005)(110136005)(83380400001)(33656002)(66476007)(71200400001)(966005)(316002)(7416002)(86362001)(66446008)(64756008)(53546011)(6506007)(6636002)(478600001)(4326008)(2906002)(76116006)(921005)(54906003)(186003)(7696005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?GkdLP3gngMWWPeweVVBjykzs5tmvHKrtmY0DRKiuVpQpPyq6MiQmQSma8OYN?=
 =?us-ascii?Q?Ac62bwyRImNDFTVFkO9eky4ZdoIPQMHUJRDqy2ibfjVfGalB1hWyuz8DinGD?=
 =?us-ascii?Q?PyE3Wh7w8GQbq5AINLG6/mYKWAXeU0KVwz564rXryqcoEpq2Vm3casPH6qfI?=
 =?us-ascii?Q?HRFny65P9gpmbxRzbmF0FNBi2XGnLLlouzc/K6/RCe2IOsD2frJtr5mYXjRB?=
 =?us-ascii?Q?AJFjrkwJMzBHJ4g30csQhZKLrlXoFb+gy7ka7geuq0FlZPMtlUnPFi00jlTf?=
 =?us-ascii?Q?RbZ6FxXpVMsgQ8e1lGESvczJnPWh/q2Cys3xCvKpmsutuYFk1rOZp1q97yES?=
 =?us-ascii?Q?vCFSv+w1Sk5eFXg/WGd/lE3Goyw6FBl77x3VS+a1yc6hMOW3cIy4aE0iOf/a?=
 =?us-ascii?Q?yIGc6Lqf04Uqx0vQPbvsEu1JJ70btRs8i/CYKC6NweMUTde/DFia7h62BOyE?=
 =?us-ascii?Q?PumloQu9W7XiN1V6DYlxbYPbJpC3/GECNb2t4hWJqiTdgM9bbn+Ig6i+FPyA?=
 =?us-ascii?Q?aCVsAbftVJIfGo5yf5CI1LhGub09QZ+Luj1Rzh/n3znZGvCFvCFNkM5CI3W4?=
 =?us-ascii?Q?scXNu0ViwGiFIRB8EqaO3IpD9XXb7VCdW8gpf0VsVDuT6uwbwgeEbrD4m/gg?=
 =?us-ascii?Q?ShtHG30qe4RA1FqJYhNIkqfKtynjMMyF9N2u+hX9IW6XE8unBUlrgj/Pe140?=
 =?us-ascii?Q?pHXG9Qwex66CwjTLdXnnooIWge/yVZshUGOxXMkY+4vns21yleSGu+LUOVLz?=
 =?us-ascii?Q?1Qqvx04b7hKyTTRDpoEjLecLUA6/Bt4x77mlWfYlPLHtDAI9w7zE1A0a8X6x?=
 =?us-ascii?Q?mW8qQbn5/fRctOw0gMLQ/qwGvTebhgVlGf1SqDh4Pqjw1Y3ms+h82AMfF5E1?=
 =?us-ascii?Q?+IFGDXWs48IyQxPwZKx/kRwPcgSMGJPQ0UE5cnQxSgZgeWMlHRlHzpF5C4pF?=
 =?us-ascii?Q?OUwo25Fnn1c+jXGVvlVkFB2tYcponJXfVomzEv8dR5ZTO+Vp09cenQRXF86i?=
 =?us-ascii?Q?UJTJ6GRx3U4To3f06ReFX9FoEvzL1m0EoFwOh8L0B40mpnBzcZvlEOyBh+fg?=
 =?us-ascii?Q?WUlFQWum7FkgxYfw+AlnZ1SaWSvaaAfMHm6TfCRuv9fXL1lgGA/DvCmYatzJ?=
 =?us-ascii?Q?LsvHmb0LaLx15o62lAfa7StF6pjy8aV/HSVeO9NTgjsUFcIAfOHgqTsXKNQD?=
 =?us-ascii?Q?4WFBy56rT6Rvim4iQfzJPpwoEFB88Arab/xZr0FNFeosUoDiywW41T5NXfQg?=
 =?us-ascii?Q?pYWunzZ6UKEBvzZMoBrYOxZsb7uAqMm9aPNQA9DCQXvHOr3yO5G8pj4cSfsP?=
 =?us-ascii?Q?cSU=3D?=
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4456
Original-Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT017.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: e3ca74e5-cc63-4b9d-4229-08d8f36252d1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SvLVp7EWCERWJUttIcc/RsAc46sYDWwsEV/rNcZ+z6F6kfJXYevKPwueKsjUumdHjU7r/73ww/bH3CXZL+tI6tXRldZGLjl/dLxZqHCsCWZl17b5yAmJW5kG9eKQqgMvjeaDa3cfeS3QNzaJVBnZr6Gh/0qwZTte96MOzQ3/km+AyW8uPn7w74DzY1N8hkwTWK9BGl/q9UqzENfa4nQspgscMpW34/aRe1TmBdRikvNXsyMj9EvGQA1czozO93ii78rDKgONpElId8zo67JLi0GK9hmfrQn5T/WVXtPZ5K41O8bVr5B+Y0LnMZUzt80yDwsLbqfctgw36DnDeCkz6nagqOh0AkTB2BJjlzFLxVJbUUbjEmQPClYf+UjRzL2fkGC4wzG2KxdFkpmUct4nPAdGVyJm9tCJuWhad8MBBRSuC67e96OY5b8bDKcqSkiE1BR7XpIm9kxH1J2v8VvBvKzcwiWRVhm/vqNICUpxwhJTIZ+Z0nPGcA6dXnT0c7JtRKfear5+xGMV9g9S7ZAyevbU8+6cuDyvCko8/gx9p0Hm6Xnt+x8Vwbi5VAXl86etzARUI4jeDFp5NLGz0ZCHgPY70LzhabDZ0Ola1+ZbTr9/bObUdyDu1MqcPx7uPHqLq08gnD29O7N1Jf+xCUXGEiAVIsOGaM1d8leu31LiehfoAoNy7YH6ZB6FaSFTw40V9mx1oucNWWnThYXcqsY8RZnUmWBRUo+5yj5eBuuPyToX0RNZMz9HM/wYBuFwJdAo
X-Forefront-Antispam-Report: CIP:63.35.35.123; CTRY:IE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:64aa7808-outbound-1.mta.getcheckrecipient.com;
 PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com; CAT:NONE;
 SFS:(4636009)(376002)(136003)(39850400004)(396003)(346002)(46966006)(36840700001)(8936002)(186003)(36860700001)(47076005)(316002)(336012)(110136005)(52536014)(478600001)(966005)(8676002)(86362001)(356005)(70206006)(26005)(5660300002)(107886003)(54906003)(55016002)(2906002)(82310400003)(82740400003)(81166007)(4326008)(53546011)(6506007)(9686003)(70586007)(921005)(33656002)(83380400001)(7696005)(6636002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2021 09:58:24.6780 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f388d03-394e-40a5-7c96-08d8f3625bed
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[63.35.35.123];
 Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: AM5EUR03FT017.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB5857
Cc: Justin He <Justin.He@arm.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "kernel-team@android.com" <kernel-team@android.com>,
 "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu

Ping ...
Any comments?

-----Original Message-----
From: Marc Zyngier <maz@kernel.org> 
Sent: Monday, February 8, 2021 9:40 PM
To: netdev@vger.kernel.org; yangbo.lu@nxp.com; john.stultz@linaro.org; tglx@linutronix.de; pbonzini@redhat.com; seanjc@google.com; richardcochran@gmail.com; Mark Rutland <Mark.Rutland@arm.com>; will@kernel.org; Suzuki Poulose <Suzuki.Poulose@arm.com>; Andre Przywara <Andre.Przywara@arm.com>; Steven Price <Steven.Price@arm.com>; Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>; Sudeep Holla <Sudeep.Holla@arm.com>
Cc: linux-kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org; kvmarm@lists.cs.columbia.edu; kvm@vger.kernel.org; Steve Capper <Steve.Capper@arm.com>; Justin He <Justin.He@arm.com>; Jianyong Wu <Jianyong.Wu@arm.com>; kernel-team@android.com
Subject: [PATCH v18 6/7] KVM: arm64: Add support for the KVM PTP service

From: Jianyong Wu <jianyong.wu@arm.com>

Implement the hypervisor side of the KVM PTP interface.

The service offers wall time and cycle count from host to guest.
The caller must specify whether they want the host's view of either the virtual or physical counter.

Signed-off-by: Jianyong Wu <jianyong.wu@arm.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20201209060932.212364-7-jianyong.wu@arm.com
---
 Documentation/virt/kvm/api.rst         |  9 +++++
 Documentation/virt/kvm/arm/index.rst   |  1 +
 Documentation/virt/kvm/arm/ptp_kvm.rst | 25 ++++++++++++
 arch/arm64/kvm/arm.c                   |  1 +
 arch/arm64/kvm/hypercalls.c            | 53 ++++++++++++++++++++++++++
 include/linux/arm-smccc.h              | 16 ++++++++
 include/uapi/linux/kvm.h               |  1 +
 7 files changed, 106 insertions(+)
 create mode 100644 Documentation/virt/kvm/arm/ptp_kvm.rst

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst index c136e254b496..7123bedd4248 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -6501,3 +6501,12 @@ KVM_GET_DIRTY_LOG and KVM_CLEAR_DIRTY_LOG.  After enabling  KVM_CAP_DIRTY_LOG_RING with an acceptable dirty ring size, the virtual  machine will switch to ring-buffer dirty page tracking and further  KVM_GET_DIRTY_LOG or KVM_CLEAR_DIRTY_LOG ioctls will fail.
+
+8.30 KVM_CAP_PTP_KVM
+--------------------
+
+:Architectures: arm64
+
+This capability indicates that the KVM virtual PTP service is supported 
+in the host. A VMM can check whether the service is available to the 
+guest on migration.
diff --git a/Documentation/virt/kvm/arm/index.rst b/Documentation/virt/kvm/arm/index.rst
index 3e2b2aba90fc..78a9b670aafe 100644
--- a/Documentation/virt/kvm/arm/index.rst
+++ b/Documentation/virt/kvm/arm/index.rst
@@ -10,3 +10,4 @@ ARM
    hyp-abi
    psci
    pvtime
+   ptp_kvm
diff --git a/Documentation/virt/kvm/arm/ptp_kvm.rst b/Documentation/virt/kvm/arm/ptp_kvm.rst
new file mode 100644
index 000000000000..68cffb50d8bf
--- /dev/null
+++ b/Documentation/virt/kvm/arm/ptp_kvm.rst
@@ -0,0 +1,25 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+PTP_KVM support for arm/arm64
+=============================
+
+PTP_KVM is used for high precision time sync between host and guests.
+It relies on transferring the wall clock and counter value from the 
+host to the guest using a KVM-specific hypercall.
+
+* ARM_SMCCC_HYP_KVM_PTP_FUNC_ID: 0x86000001
+
+This hypercall uses the SMC32/HVC32 calling convention:
+
+ARM_SMCCC_HYP_KVM_PTP_FUNC_ID
+    =============    ==========    ==========
+    Function ID:     (uint32)      0x86000001
+    Arguments:       (uint32)      KVM_PTP_VIRT_COUNTER(0)
+                                   KVM_PTP_PHYS_COUNTER(1)
+    Return Values:   (int32)       NOT_SUPPORTED(-1) on error, or
+                     (uint32)      Upper 32 bits of wall clock time (r0)
+                     (uint32)      Lower 32 bits of wall clock time (r1)
+                     (uint32)      Upper 32 bits of counter (r2)
+                     (uint32)      Lower 32 bits of counter (r3)
+    Endianness:                    No Restrictions.
+    =============    ==========    ==========
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c index 04c44853b103..7ce851fc5643 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -206,6 +206,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 	case KVM_CAP_ARM_INJECT_EXT_DABT:
 	case KVM_CAP_SET_GUEST_DEBUG:
 	case KVM_CAP_VCPU_ATTRIBUTES:
+	case KVM_CAP_PTP_KVM:
 		r = 1;
 		break;
 	case KVM_CAP_ARM_SET_DEVICE_ADDR:
diff --git a/arch/arm64/kvm/hypercalls.c b/arch/arm64/kvm/hypercalls.c index b9d8607083eb..71812879f503 100644
--- a/arch/arm64/kvm/hypercalls.c
+++ b/arch/arm64/kvm/hypercalls.c
@@ -9,6 +9,55 @@
 #include <kvm/arm_hypercalls.h>
 #include <kvm/arm_psci.h>
 
+static void kvm_ptp_get_time(struct kvm_vcpu *vcpu, u64 *val) {
+	struct system_time_snapshot systime_snapshot;
+	u64 cycles = ~0UL;
+	u32 feature;
+
+	/*
+	 * system time and counter value must captured at the same
+	 * time to keep consistency and precision.
+	 */
+	ktime_get_snapshot(&systime_snapshot);
+
+	/*
+	 * This is only valid if the current clocksource is the
+	 * architected counter, as this is the only one the guest
+	 * can see.
+	 */
+	if (systime_snapshot.cs_id != CSID_ARM_ARCH_COUNTER)
+		return;
+
+	/*
+	 * The guest selects one of the two reference counters
+	 * (virtual or physical) with the first argument of the SMCCC
+	 * call. In case the identifier is not supported, error out.
+	 */
+	feature = smccc_get_arg1(vcpu);
+	switch (feature) {
+	case KVM_PTP_VIRT_COUNTER:
+		cycles = systime_snapshot.cycles - vcpu_read_sys_reg(vcpu, CNTVOFF_EL2);
+		break;
+	case KVM_PTP_PHYS_COUNTER:
+		cycles = systime_snapshot.cycles;
+		break;
+	default:
+		return;
+	}
+
+	/*
+	 * This relies on the top bit of val[0] never being set for
+	 * valid values of system time, because that is *really* far
+	 * in the future (about 292 years from 1970, and at that stage
+	 * nobody will give a damn about it).
+	 */
+	val[0] = upper_32_bits(systime_snapshot.real);
+	val[1] = lower_32_bits(systime_snapshot.real);
+	val[2] = upper_32_bits(cycles);
+	val[3] = lower_32_bits(cycles);
+}
+
 int kvm_hvc_call_handler(struct kvm_vcpu *vcpu)  {
 	u32 func_id = smccc_get_function(vcpu); @@ -79,6 +128,10 @@ int kvm_hvc_call_handler(struct kvm_vcpu *vcpu)
 		break;
 	case ARM_SMCCC_VENDOR_HYP_KVM_FEATURES_FUNC_ID:
 		val[0] = BIT(ARM_SMCCC_KVM_FUNC_FEATURES);
+		val[0] |= BIT(ARM_SMCCC_KVM_FUNC_PTP);
+		break;
+	case ARM_SMCCC_VENDOR_HYP_KVM_PTP_FUNC_ID:
+		kvm_ptp_get_time(vcpu, val);
 		break;
 	default:
 		return kvm_psci_call(vcpu);
diff --git a/include/linux/arm-smccc.h b/include/linux/arm-smccc.h index 74e90b65b489..96d4973d42d3 100644
--- a/include/linux/arm-smccc.h
+++ b/include/linux/arm-smccc.h
@@ -103,6 +103,7 @@
 
 /* KVM "vendor specific" services */
 #define ARM_SMCCC_KVM_FUNC_FEATURES		0
+#define ARM_SMCCC_KVM_FUNC_PTP			1
 #define ARM_SMCCC_KVM_FUNC_FEATURES_2		127
 #define ARM_SMCCC_KVM_NUM_FUNCS			128
 
@@ -114,6 +115,21 @@
 
 #define SMCCC_ARCH_WORKAROUND_RET_UNAFFECTED	1
 
+/*
+ * ptp_kvm is a feature used for time sync between vm and host.
+ * ptp_kvm module in guest kernel will get service from host using
+ * this hypercall ID.
+ */
+#define ARM_SMCCC_VENDOR_HYP_KVM_PTP_FUNC_ID				\
+	ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL,				\
+			   ARM_SMCCC_SMC_32,				\
+			   ARM_SMCCC_OWNER_VENDOR_HYP,			\
+			   ARM_SMCCC_KVM_FUNC_PTP)
+
+/* ptp_kvm counter type ID */
+#define KVM_PTP_VIRT_COUNTER			0
+#define KVM_PTP_PHYS_COUNTER			1
+
 /* Paravirtualised time calls (defined by ARM DEN0057A) */
 #define ARM_SMCCC_HV_PV_TIME_FEATURES				\
 	ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL,			\
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h index 374c67875cdb..ef75c3532759 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -1058,6 +1058,7 @@ struct kvm_ppc_resize_hpt {  #define KVM_CAP_ENFORCE_PV_FEATURE_CPUID 190  #define KVM_CAP_SYS_HYPERV_CPUID 191  #define KVM_CAP_DIRTY_LOG_RING 192
+#define KVM_CAP_PTP_KVM 193
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
--
2.29.2

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
