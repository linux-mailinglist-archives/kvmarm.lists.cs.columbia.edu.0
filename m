Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 918CC53E432
	for <lists+kvmarm@lfdr.de>; Mon,  6 Jun 2022 13:23:23 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id E6E424B259;
	Mon,  6 Jun 2022 07:23:22 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.789
X-Spam-Level: 
X-Spam-Status: No, score=-1.789 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, SPF_HELO_PASS=-0.001, T_DKIM_INVALID=0.01,
	UNPARSEABLE_RELAY=0.001, URIBL_BLOCKED=0.001] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@armh.onmicrosoft.com
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@armh.onmicrosoft.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zgn01yWW5qLD; Mon,  6 Jun 2022 07:23:22 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 86B934B19F;
	Mon,  6 Jun 2022 07:23:20 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 913DD404FD
 for <kvmarm@lists.cs.columbia.edu>; Mon,  6 Jun 2022 06:35:47 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id enfx3urywYLN for <kvmarm@lists.cs.columbia.edu>;
 Mon,  6 Jun 2022 06:35:45 -0400 (EDT)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-eopbgr80045.outbound.protection.outlook.com [40.107.8.45])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 1B71840465
 for <kvmarm@lists.cs.columbia.edu>; Mon,  6 Jun 2022 06:35:45 -0400 (EDT)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=IiFJv7n9PWfmynU1AfYpPoRtJ+uq5iON6jLYnkKE+ndCM9e4S/45/o6yo5DgUZV9RbaHzt3MgdLq9FCivbMOvB0ZIv0/5HOTexarGkzMYJJ46Io5icHw86sY1lnodIciSAoN+TFCxUA80SJ6tS5c/HS+vtikBw4cY4LMg+PD6yJVATS/2xJ+V/MNHxu5h14xwf9fnRBwRnhYvT1VVM9TDA2vIbV3naCzcHU3L/RyI5hjQ20RDpERK4FuGrfOT1DpIFTnsz1tkoSNnBmuPNq8AzHeKm/JV2phNkODpxbE0DIAJMxXXizJ7jL2h7Yt4BYOuqYKdDcReWUhHFCvfRxYnA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nrx9JbDW/p2lvXBHZ/WSxp6X4PivTvPIp+MYoS0A0JY=;
 b=P8DMFlOF/vxTgzMIwA34S4Yb+k3/mdjaxnM9GUu3oyrmalzyK+yPbrnm9zn2ZI2L585bA2NEbeMfFKCgKcQ9Aghvy/4IItjwS3s40qRWPHBrEirkSBKwiZXuribxp7lv5s71hK2xj4rPaqlQ/+ip76ZzWl76qUHJtbLV/7dbBuFSLxroEqhc6q2SulynWYPcDI8ULHhDIodX7/iaQWGq6KdG9GOHdaTWtZQIB8uX2w02+BzLflUHwTgYKubzU1MLqIrm1b/KZB3GKPrtMAAwrHT0nRIgDU/9gSKxH/HknLiHd8pCoh0UJVFlm9h4ZlNpGqfQkjpdXl/4cOCXBelB1g==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=lists.cs.columbia.edu smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=armh.onmicrosoft.com; arc=pass (0
 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com; 
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nrx9JbDW/p2lvXBHZ/WSxp6X4PivTvPIp+MYoS0A0JY=;
 b=3L3hKYd1JVwviZ8wHtMNeeFXXL+YkizsvtWrVz5YATh5Fc3Fq2QM7HmEutsbyI+MDUhJHmlLqQkBvfjbcXkycmxRZbkyq0C9N4fHbdK6+LFeCEM1Neg/HJYgYXqt2R3oof+CfKqh6MugGGcUpDoJQLcOEflml76+9ozL/3DKz3Q=
Received: from DU2PR04CA0001.eurprd04.prod.outlook.com (2603:10a6:10:3b::6) by
 AM8PR08MB6563.eurprd08.prod.outlook.com (2603:10a6:20b:315::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Mon, 6 Jun
 2022 10:35:39 +0000
Received: from DBAEUR03FT011.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:10:3b:cafe::52) by DU2PR04CA0001.outlook.office365.com
 (2603:10a6:10:3b::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.19 via Frontend
 Transport; Mon, 6 Jun 2022 10:35:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DBAEUR03FT011.mail.protection.outlook.com (100.127.142.132) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5314.12 via Frontend Transport; Mon, 6 Jun 2022 10:35:39 +0000
Received: ("Tessian outbound 5b5a41c043d3:v120");
 Mon, 06 Jun 2022 10:35:39 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: a11360800a20d4e5
X-CR-MTA-TID: 64aa7808
Received: from 1be31d08754a.1
 by 64aa7808-outbound-1.mta.getcheckrecipient.com id
 BB15BCB2-17E0-4736-A862-2CF730FCEA41.1; 
 Mon, 06 Jun 2022 10:35:32 +0000
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 1be31d08754a.1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
 Mon, 06 Jun 2022 10:35:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KejBsQEymtCctalG0SF3zzFx+p/I6T4Zma4PLDpKtE+wIjD4PYvbF+jhnVTab285uGSJw5H5BmBFMiYSOJJdv9yjk3VL238CiAIu9WaZ432M40oCypo7JZ9C3ZZW3h779rTrbiabCmwuCQJemPTx1BVFbpdeC/iRoVuFTvyvOdnkFnLoNAZyEjzGRiIsT143Ootvf/4WGhjGw+7MMWV/08WhQIf+nP9qh+txRfhvpLX8yiBN8ZpymgU2zv07ndONfVFq8z8kp8YXyF6gnaBFAdp+3lSOm9K0Apio/iQrY2ygQszfeNWnuHE8Ux8CPWCrS2J4VSEN5SB7U3gUfJmNQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nrx9JbDW/p2lvXBHZ/WSxp6X4PivTvPIp+MYoS0A0JY=;
 b=Xj3P2j7oWYE2mzdakBajKudsSrQUT+3n9XuuFsFhGcGWKadRdaf9npoQolJvgAfzGeE01cVy9T/F7Fiag/1/1VedQ1YeoLsex4hl1LCpAESr9Wk1c5uKWlcaW2piqFVjwYvUZeZHDcJ8bS8KGX66w3iKnVVubSChMrHAkqUYGXnbzCVzaaZhoDF7yj2lgzf19/+zaVM8SgKMFT+b2kCEQhkPC7ghYV+EtiWAHV5M0eEgK0lYKzwirTn3w9BA/MWGQhIqTBrPGQG9evXQm+94NtMmgMbsRPqVCQWh+nyukvG1uVAp441QgE5TvSuasHU5E0ckZO76l0+DZwUPcjNBdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com; 
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nrx9JbDW/p2lvXBHZ/WSxp6X4PivTvPIp+MYoS0A0JY=;
 b=3L3hKYd1JVwviZ8wHtMNeeFXXL+YkizsvtWrVz5YATh5Fc3Fq2QM7HmEutsbyI+MDUhJHmlLqQkBvfjbcXkycmxRZbkyq0C9N4fHbdK6+LFeCEM1Neg/HJYgYXqt2R3oof+CfKqh6MugGGcUpDoJQLcOEflml76+9ozL/3DKz3Q=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI1PR08MB3919.eurprd08.prod.outlook.com (2603:10a6:803:c4::31)
 by DB9PR08MB7819.eurprd08.prod.outlook.com (2603:10a6:10:39b::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.19; Mon, 6 Jun
 2022 10:35:30 +0000
Received: from VI1PR08MB3919.eurprd08.prod.outlook.com
 ([fe80::9545:ff73:df89:3e50]) by VI1PR08MB3919.eurprd08.prod.outlook.com
 ([fe80::9545:ff73:df89:3e50%7]) with mapi id 15.20.5314.019; Mon, 6 Jun 2022
 10:35:30 +0000
Message-ID: <3ce1d0fb-f323-a742-4b57-d8ecc00574aa@arm.com>
Date: Mon, 6 Jun 2022 11:35:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v12 06/40] arm64/sme: Provide ABI documentation for SME
Content-Language: en-US
To: Mark Brown <broonie@kernel.org>, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Marc Zyngier <maz@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>,
 Shuah Khan <shuah@kernel.org>
References: <20220225165923.1474372-1-broonie@kernel.org>
 <20220225165923.1474372-7-broonie@kernel.org>
From: Luis Machado <luis.machado@arm.com>
In-Reply-To: <20220225165923.1474372-7-broonie@kernel.org>
X-ClientProxiedBy: SA9P221CA0010.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:806:25::15) To VI1PR08MB3919.eurprd08.prod.outlook.com
 (2603:10a6:803:c4::31)
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 771a3504-a68c-4fa3-522e-08da47a84c9c
X-MS-TrafficTypeDiagnostic: DB9PR08MB7819:EE_|DBAEUR03FT011:EE_|AM8PR08MB6563:EE_
X-Microsoft-Antispam-PRVS: <AM8PR08MB656327FFDB70E36D51FF40688BA29@AM8PR08MB6563.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: pwClXx+DKEnE7pYEW7PWYGKarKzzHLjzY4BARfHuvpFzQH2OLYOOMPDd29rnkmzXgFTzVDypbzLEGZWT9Rld7Oo6C/a85A1bmPcewYDHNSivk1Dtom8ae1Hk88I1evnLaP3ooL/NhOQb9AQDwuRd/hePseDphtcQWdyWu+Jl6tezxoriFiJrjOWBJC9fs751rCqeXAS1c8B+p+cJS0IlvLku4e0gckWLLum7HUU1U6UspuI9CXfvZFLSvEjsYdkDLZ1+AeMDQGz2bY66ljrHVVt2o9RAC6yNAAIpAqRIXy9VN+1xMEw82lj3rGQ7gHIYP28HxxlGVMbXUuPFPMtT3Sw4n3bwj7lAEZsPSTgaqiAJScNtJk6RoUJiEk8dulez1zgaYfA57KVG7vJxO5a4rDaH2UlUwo9Xlr2Gg6P+VOdDDWjLlkKruS4d1JvBWc69bBZpqU8gFeAwMngSvmF+fzhw2DEk2olOSs6RdKifCfW3Knb+5lkGuq/NleBYZHBJYPVBIzpfn/HS54Gya6HDlrhzm1/+c0CKIwrq/bSeNat306+pXPxIqBc7jHCaENbr68dkEm29le/TQI+3Jy7J722+uW26gu/pjtiMOOfAlQSqFbTDNJzUPpzihVfxRB2L3YZnn+1HbjeCFTKovxGHAREyVIAlP56GuZ0Urj7fmG6PpIs54kVBfWRtqxa5yl4y6rdmholOpl2dSWnySiJvwKlakaWOVVIn5EryLS7Ih6c=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:VI1PR08MB3919.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(36756003)(54906003)(316002)(8676002)(38100700002)(31686004)(5660300002)(4326008)(66946007)(83380400001)(66556008)(30864003)(44832011)(66476007)(53546011)(26005)(6506007)(6512007)(6486002)(186003)(86362001)(110136005)(508600001)(8936002)(2906002)(2616005)(6666004)(31696002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB7819
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DBAEUR03FT011.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 5bffb36b-8bfa-4eed-e67b-08da47a84766
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 35/rEGEu27f27PGb1NVssZ5L/NQYhTnYg6mq8qjzqKi2WVD9q++XaC/dm8Yq6s7oH5lAvGNYY7QihUVXj+Ym67TdY9URmxgTYfmpvEiTQAlcDd0ZolyqZHWXMt2hgMohyv11vuhhNpBjRU0S0WkkIHGVvRYEjY6mXc2BFPvKnyJeXojvJq4M1QRtRQCGeAdj4S46U3qlqI1s9OzeYRGFDztYOTTVQMDQj3N7OyONoqJhLSIQJq+Y5X492jpng2rYNbIsn3rid7hnRQWyL5Yb4NnDbwJcxd2WrB0/zV4xuM29WpuLYw1d3k/br8zSrhEgiFNf3xn7RixSAPCdzRLkRhnRII5/cLPmjSUiQ0JwlR6Ue3gLjUxHgHvKdDmFFeeVGjcXA5VzTQIxygpvCd9wAwVWhL6O8Gc5L6TYz+rwQcreAd9iyJZ0aP+XkkmSfeQJHs1D+YnvRpsSinOUB5lFCgccII7uP/FYRUInH/merA/b8Esm5nGePzOipQdUCrPq2zsM/GUR8RBg7EhL+iHGT10nehzk/sDAAzJQSv0F7/shJs1WHmdnrgTmx3LYWvp70eqRjuaXdPSpZ6i/OyOlSexZFf+wCdDTEXx89tWL0dTXnG83rraeLlflNHtxIGcLxYJv3jIGcnRcwoB0ieodzOgWra8OUCT1AcganXGkYd09U9X81nnYf7sSLyKv1iqK4f6u+Zetw0qjnW67G5pz4g==
X-Forefront-Antispam-Report: CIP:63.35.35.123; CTRY:IE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:64aa7808-outbound-1.mta.getcheckrecipient.com;
 PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(5660300002)(8936002)(44832011)(70206006)(8676002)(82310400005)(2906002)(70586007)(36756003)(40460700003)(2616005)(186003)(316002)(26005)(81166007)(336012)(83380400001)(6512007)(31686004)(356005)(54906003)(110136005)(30864003)(31696002)(6506007)(53546011)(47076005)(6486002)(4326008)(86362001)(36860700001)(6666004)(508600001)(43740500002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2022 10:35:39.1737 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 771a3504-a68c-4fa3-522e-08da47a84c9c
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[63.35.35.123];
 Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: DBAEUR03FT011.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB6563
X-Mailman-Approved-At: Mon, 06 Jun 2022 07:23:18 -0400
Cc: Basant Kumar Dwivedi <Basant.KumarDwivedi@arm.com>,
 Szabolcs Nagy <szabolcs.nagy@arm.com>, linux-arm-kernel@lists.infradead.org,
 linux-kselftest@vger.kernel.org, Alan Hayward <alan.hayward@arm.com>,
 kvmarm@lists.cs.columbia.edu, Salil Akerkar <Salil.Akerkar@arm.com>
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu

On 2/25/22 16:58, Mark Brown wrote:
> Provide ABI documentation for SME similar to that for SVE. Due to the very
> large overlap around streaming SVE mode in both implementation and
> interfaces documentation for streaming mode SVE is added to the SVE
> document rather than the SME one.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>   Documentation/arm64/index.rst |   1 +
>   Documentation/arm64/sme.rst   | 427 ++++++++++++++++++++++++++++++++++
>   Documentation/arm64/sve.rst   |  70 +++++-
>   3 files changed, 488 insertions(+), 10 deletions(-)
>   create mode 100644 Documentation/arm64/sme.rst
> 
> diff --git a/Documentation/arm64/index.rst b/Documentation/arm64/index.rst
> index 4f840bac083e..ae21f8118830 100644
> --- a/Documentation/arm64/index.rst
> +++ b/Documentation/arm64/index.rst
> @@ -21,6 +21,7 @@ ARM64 Architecture
>       perf
>       pointer-authentication
>       silicon-errata
> +    sme
>       sve
>       tagged-address-abi
>       tagged-pointers
> diff --git a/Documentation/arm64/sme.rst b/Documentation/arm64/sme.rst
> new file mode 100644
> index 000000000000..0493838bdc44
> --- /dev/null
> +++ b/Documentation/arm64/sme.rst
> @@ -0,0 +1,427 @@
> +===================================================
> +Scalable Matrix Extension support for AArch64 Linux
> +===================================================
> +
> +This document outlines briefly the interface provided to userspace by Linux in
> +order to support use of the ARM Scalable Matrix Extension (SME).
> +
> +This is an outline of the most important features and issues only and not
> +intended to be exhaustive.  It should be read in conjunction with the SVE
> +documentation in sve.rst which provides details on the Streaming SVE mode
> +included in SME.
> +
> +This document does not aim to describe the SME architecture or programmer's
> +model.  To aid understanding, a minimal description of relevant programmer's
> +model features for SME is included in Appendix A.
> +
> +
> +1.  General
> +-----------
> +
> +* PSTATE.SM, PSTATE.ZA, the streaming mode vector length, the ZA
> +  register state and TPIDR2_EL0 are tracked per thread.
> +
> +* The presence of SME is reported to userspace via HWCAP2_SME in the aux vector
> +  AT_HWCAP2 entry.  Presence of this flag implies the presence of the SME
> +  instructions and registers, and the Linux-specific system interfaces
> +  described in this document.  SME is reported in /proc/cpuinfo as "sme".
> +
> +* Support for the execution of SME instructions in userspace can also be
> +  detected by reading the CPU ID register ID_AA64PFR1_EL1 using an MRS
> +  instruction, and checking that the value of the SME field is nonzero. [3]
> +
> +  It does not guarantee the presence of the system interfaces described in the
> +  following sections: software that needs to verify that those interfaces are
> +  present must check for HWCAP2_SME instead.
> +
> +* There are a number of optional SME features, presence of these is reported
> +  through AT_HWCAP2 through:
> +
> +	HWCAP2_SME_I16I64
> +	HWCAP2_SME_F64F64
> +	HWCAP2_SME_I8I32
> +	HWCAP2_SME_F16F32
> +	HWCAP2_SME_B16F32
> +	HWCAP2_SME_F32F32
> +	HWCAP2_SME_FA64
> +
> +  This list may be extended over time as the SME architecture evolves.
> +
> +  These extensions are also reported via the CPU ID register ID_AA64SMFR0_EL1,
> +  which userspace can read using an MRS instruction.  See elf_hwcaps.txt and
> +  cpu-feature-registers.txt for details.
> +
> +* Debuggers should restrict themselves to interacting with the target via the
> +  NT_ARM_SVE, NT_ARM_SSVE and NT_ARM_ZA regsets.  The recommended way
> +  of detecting support for these regsets is to connect to a target process
> +  first and then attempt a
> +
> +	ptrace(PTRACE_GETREGSET, pid, NT_ARM_<regset>, &iov).
> +
> +* Whenever ZA register values are exchanged in memory between userspace and
> +  the kernel, the register value is encoded in memory as a series of horizontal
> +  vectors from 0 to VL/8-1 stored in the same endianness invariant format as is
> +  used for SVE vectors.
> +
> +* On thread creation TPIDR2_EL0 is preserved unless CLONE_SETTLS is specified,
> +  in which case it is set to 0.
> +
> +2.  Vector lengths
> +------------------
> +
> +SME defines a second vector length similar to the SVE vector length which is
> +controls the size of the streaming mode SVE vectors and the ZA matrix array.
> +The ZA matrix is square with each side having as many bytes as a SVE vector.
> +
> +
> +3.  Sharing of streaming and non-streaming mode SVE state
> +---------------------------------------------------------
> +
> +It is implementation defined which if any parts of the SVE state are shared
> +between streaming and non-streaming modes.  When switching between modes
> +via software interfaces such as ptrace if no register content is provided as
> +part of switching no state will be assumed to be shared and everything will
> +be zeroed.
> +
> +
> +4.  System call behaviour
> +-------------------------
> +
> +* On syscall PSTATE.ZA is preserved, if PSTATE.ZA==1 then the contents of the
> +  ZA matrix are preserved.
> +
> +* On syscall PSTATE.SM will be cleared and the SVE registers will be handled
> +  as normal.
> +
> +* Neither the SVE registers nor ZA are used to pass arguments to or receive
> +  results from any syscall.
> +
> +* On creation fork() or clone() the newly created process will have PSTATE.SM
> +  and PSTATE.ZA cleared.
> +
> +* All other SME state of a thread, including the currently configured vector
> +  length, the state of the PR_SME_VL_INHERIT flag, and the deferred vector
> +  length (if any), is preserved across all syscalls, subject to the specific
> +  exceptions for execve() described in section 6.
> +
> +
> +5.  Signal handling
> +-------------------
> +
> +* Signal handlers are invoked with streaming mode and ZA disabled.
> +
> +* A new signal frame record za_context encodes the ZA register contents on
> +  signal delivery. [1]
> +
> +* The signal frame record for ZA always contains basic metadata, in particular
> +  the thread's vector length (in za_context.vl).
> +
> +* The ZA matrix may or may not be included in the record, depending on
> +  the value of PSTATE.ZA.  The registers are present if and only if:
> +  za_context.head.size >= ZA_SIG_CONTEXT_SIZE(sve_vq_from_vl(za_context.vl))
> +  in which case PSTATE.ZA == 1.
> +
> +* If matrix data is present, the remainder of the record has a vl-dependent
> +  size and layout.  Macros ZA_SIG_* are defined [1] to facilitate access to
> +  them.
> +
> +* The matrix is stored as a series of horizontal vectors in the same format as
> +  is used for SVE vectors.
> +
> +* If the ZA context is too big to fit in sigcontext.__reserved[], then extra
> +  space is allocated on the stack, an extra_context record is written in
> +  __reserved[] referencing this space.  za_context is then written in the
> +  extra space.  Refer to [1] for further details about this mechanism.
> +
> +
> +5.  Signal return
> +-----------------
> +
> +When returning from a signal handler:
> +
> +* If there is no za_context record in the signal frame, or if the record is
> +  present but contains no register data as described in the previous section,
> +  then ZA is disabled.
> +
> +* If za_context is present in the signal frame and contains matrix data then
> +  PSTATE.ZA is set to 1 and ZA is populated with the specified data.
> +
> +* The vector length cannot be changed via signal return.  If za_context.vl in
> +  the signal frame does not match the current vector length, the signal return
> +  attempt is treated as illegal, resulting in a forced SIGSEGV.
> +
> +
> +6.  prctl extensions
> +--------------------
> +
> +Some new prctl() calls are added to allow programs to manage the SME vector
> +length:
> +
> +prctl(PR_SME_SET_VL, unsigned long arg)
> +
> +    Sets the vector length of the calling thread and related flags, where
> +    arg == vl | flags.  Other threads of the calling process are unaffected.
> +
> +    vl is the desired vector length, where sve_vl_valid(vl) must be true.
> +
> +    flags:
> +
> +	PR_SME_VL_INHERIT
> +
> +	    Inherit the current vector length across execve().  Otherwise, the
> +	    vector length is reset to the system default at execve().  (See
> +	    Section 9.)
> +
> +	PR_SME_SET_VL_ONEXEC
> +
> +	    Defer the requested vector length change until the next execve()
> +	    performed by this thread.
> +
> +	    The effect is equivalent to implicit execution of the following
> +	    call immediately after the next execve() (if any) by the thread:
> +
> +		prctl(PR_SME_SET_VL, arg & ~PR_SME_SET_VL_ONEXEC)
> +
> +	    This allows launching of a new program with a different vector
> +	    length, while avoiding runtime side effects in the caller.
> +
> +	    Without PR_SME_SET_VL_ONEXEC, the requested change takes effect
> +	    immediately.
> +
> +
> +    Return value: a nonnegative on success, or a negative value on error:
> +	EINVAL: SME not supported, invalid vector length requested, or
> +	    invalid flags.
> +
> +
> +    On success:
> +
> +    * Either the calling thread's vector length or the deferred vector length
> +      to be applied at the next execve() by the thread (dependent on whether
> +      PR_SME_SET_VL_ONEXEC is present in arg), is set to the largest value
> +      supported by the system that is less than or equal to vl.  If vl ==
> +      SVE_VL_MAX, the value set will be the largest value supported by the
> +      system.
> +
> +    * Any previously outstanding deferred vector length change in the calling
> +      thread is cancelled.
> +
> +    * The returned value describes the resulting configuration, encoded as for
> +      PR_SME_GET_VL.  The vector length reported in this value is the new
> +      current vector length for this thread if PR_SME_SET_VL_ONEXEC was not
> +      present in arg; otherwise, the reported vector length is the deferred
> +      vector length that will be applied at the next execve() by the calling
> +      thread.
> +
> +    * Changing the vector length causes all of ZA, P0..P15, FFR and all bits of
> +      Z0..Z31 except for Z0 bits [127:0] .. Z31 bits [127:0] to become
> +      unspecified, including both streaming and non-streaming SVE state.
> +      Calling PR_SME_SET_VL with vl equal to the thread's current vector
> +      length, or calling PR_SME_SET_VL with the PR_SVE_SET_VL_ONEXEC flag,
> +      does not constitute a change to the vector length for this purpose.
> +
> +    * Changing the vector length causes PSTATE.ZA and PSTATE.SM to be cleared.
> +      Calling PR_SME_SET_VL with vl equal to the thread's current vector
> +      length, or calling PR_SME_SET_VL with the PR_SVE_SET_VL_ONEXEC flag,
> +      does not constitute a change to the vector length for this purpose.
> +
> +
> +prctl(PR_SME_GET_VL)
> +
> +    Gets the vector length of the calling thread.
> +
> +    The following flag may be OR-ed into the result:
> +
> +	PR_SME_VL_INHERIT
> +
> +	    Vector length will be inherited across execve().
> +
> +    There is no way to determine whether there is an outstanding deferred
> +    vector length change (which would only normally be the case between a
> +    fork() or vfork() and the corresponding execve() in typical use).
> +
> +    To extract the vector length from the result, bitwise and it with
> +    PR_SME_VL_LEN_MASK.
> +
> +    Return value: a nonnegative value on success, or a negative value on error:
> +	EINVAL: SME not supported.
> +
> +
> +7.  ptrace extensions
> +---------------------
> +
> +* A new regset NT_ARM_SSVE is defined for access to streaming mode SVE
> +  state via PTRACE_GETREGSET and  PTRACE_SETREGSET, this is documented in
> +  sve.rst.
> +
> +* A new regset NT_ARM_ZA is defined for ZA state for access to ZA state via
> +  PTRACE_GETREGSET and PTRACE_SETREGSET.
> +
> +  Refer to [2] for definitions.
> +
> +The regset data starts with struct user_za_header, containing:
> +
> +    size
> +
> +	Size of the complete regset, in bytes.
> +	This depends on vl and possibly on other things in the future.
> +
> +	If a call to PTRACE_GETREGSET requests less data than the value of
> +	size, the caller can allocate a larger buffer and retry in order to
> +	read the complete regset.
> +
> +    max_size
> +
> +	Maximum size in bytes that the regset can grow to for the target
> +	thread.  The regset won't grow bigger than this even if the target
> +	thread changes its vector length etc.
> +
> +    vl
> +
> +	Target thread's current streaming vector length, in bytes.
> +
> +    max_vl
> +
> +	Maximum possible streaming vector length for the target thread.
> +
> +    flags
> +
> +	Zero or more of the following flags, which have the same
> +	meaning and behaviour as the corresponding PR_SET_VL_* flags:
> +
> +	    SME_PT_VL_INHERIT
> +
> +	    SME_PT_VL_ONEXEC (SETREGSET only).
> +
> +* The effects of changing the vector length and/or flags are equivalent to
> +  those documented for PR_SME_SET_VL.
> +
> +  The caller must make a further GETREGSET call if it needs to know what VL is
> +  actually set by SETREGSET, unless is it known in advance that the requested
> +  VL is supported.
> +
> +* The size and layout of the payload depends on the header fields.  The
> +  SME_PT_ZA_*() macros are provided to facilitate access to the data.
> +
> +* In either case, for SETREGSET it is permissible to omit the payload, in which
> +  case the vector length and flags are changed and PSTATE.ZA is set to 0
> +  (along with any consequences of those changes).  If a payload is provided
> +  then PSTATE.ZA will be set to 1.
> +
> +* For SETREGSET, if the requested VL is not supported, the effect will be the
> +  same as if the payload were omitted, except that an EIO error is reported.
> +  No attempt is made to translate the payload data to the correct layout
> +  for the vector length actually set.  It is up to the caller to translate the
> +  payload layout for the actual VL and retry.
> +
> +* The effect of writing a partial, incomplete payload is unspecified.
> +
> +
> +8.  ELF coredump extensions
> +---------------------------
> +
> +* NT_ARM_SSVE notes will be added to each coredump for
> +  each thread of the dumped process.  The contents will be equivalent to the
> +  data that would have been read if a PTRACE_GETREGSET of the corresponding
> +  type were executed for each thread when the coredump was generated.
> +
> +* A NT_ARM_ZA note will be added to each coredump for each thread of the
> +  dumped process.  The contents will be equivalent to the data that would have
> +  been read if a PTRACE_GETREGSET of NT_ARM_ZA were executed for each thread
> +  when the coredump was generated.
> +
> +
> +9.  System runtime configuration
> +--------------------------------
> +
> +* To mitigate the ABI impact of expansion of the signal frame, a policy
> +  mechanism is provided for administrators, distro maintainers and developers
> +  to set the default vector length for userspace processes:
> +
> +/proc/sys/abi/sme_default_vector_length
> +
> +    Writing the text representation of an integer to this file sets the system
> +    default vector length to the specified value, unless the value is greater
> +    than the maximum vector length supported by the system in which case the
> +    default vector length is set to that maximum.
> +
> +    The result can be determined by reopening the file and reading its
> +    contents.
> +
> +    At boot, the default vector length is initially set to 32 or the maximum
> +    supported vector length, whichever is smaller and supported.  This
> +    determines the initial vector length of the init process (PID 1).
> +
> +    Reading this file returns the current system default vector length.
> +
> +* At every execve() call, the new vector length of the new process is set to
> +  the system default vector length, unless
> +
> +    * PR_SME_VL_INHERIT (or equivalently SME_PT_VL_INHERIT) is set for the
> +      calling thread, or
> +
> +    * a deferred vector length change is pending, established via the
> +      PR_SME_SET_VL_ONEXEC flag (or SME_PT_VL_ONEXEC).
> +
> +* Modifying the system default vector length does not affect the vector length
> +  of any existing process or thread that does not make an execve() call.
> +
> +
> +Appendix A.  SME programmer's model (informative)
> +=================================================
> +
> +This section provides a minimal description of the additions made by SVE to the
> +ARMv8-A programmer's model that are relevant to this document.

Sorry for the late feedback, but should the above be SME instead of SVE?
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
