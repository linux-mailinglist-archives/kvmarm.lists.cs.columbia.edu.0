Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 1902359FEDA
	for <lists+kvmarm@lfdr.de>; Wed, 24 Aug 2022 17:52:47 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 8810D4D2F4;
	Wed, 24 Aug 2022 11:52:46 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.79
X-Spam-Level: 
X-Spam-Status: No, score=-1.79 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, SPF_HELO_PASS=-0.001, T_DKIM_INVALID=0.01,
	URIBL_BLOCKED=0.001] autolearn=no
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@os.amperecomputing.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XCzNZzfVOwms; Wed, 24 Aug 2022 11:52:45 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 8DD394D30E;
	Wed, 24 Aug 2022 11:52:42 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 2252A4C013
 for <kvmarm@lists.cs.columbia.edu>; Wed, 24 Aug 2022 02:03:24 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aE0OqH2CFfEl for <kvmarm@lists.cs.columbia.edu>;
 Wed, 24 Aug 2022 02:03:22 -0400 (EDT)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2119.outbound.protection.outlook.com [40.107.93.119])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id E3EFC4C01B
 for <kvmarm@lists.cs.columbia.edu>; Wed, 24 Aug 2022 02:03:22 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WGln9/1HLdh9uEIyJLUUiNmtoVxiluhWXep8oGnfy67jOQgvGqB801OEPYeMtmaTN54nWhoZ1Ro9VBb+Qb+LY3PRQ/uwg1e4LjuYkNVyIOrw2IAeTGJSvVItSdX32pmN5j19fJSHcWoieOEiyZd2BZeXKwsE7ZprjeTq9ErxWLqgWCtjjpT3egc4Hql3KhZNi717C5XXsiwzp3/OL1R7G9wusM/jDN/PuEVmmANt9amP3io+VrRvRhKafvS1UYJMRQPq/Bwd8kH3f9ga3pJkVn+u2LJWpFhQMTbjiQrFiwcQESkOZZvD4OTgC5CT1QEPbKG5+ej8NQlGSslBRBn/7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hMNZhh3Q+Q0iINSFvyTaXjao3sluRWLjEuNBAJmNGF8=;
 b=mqpf562uEujZ49T1lQN82f9lydOR8ZVuf7kSyYMt1K3aACF4wfZqwkOak8hmKB6iTNJ9bjTd9QWviLlFeANGerE8Min1V3hXxDCn24RuWwQ6soHzamkOqmsDTLGPgUNh2NPS/GGZw6kqurQ6DwRVIan8XYS/jcLo4zPVqAjTGGbGMR/DtG4dNwdNBkMXK7lhAC0z7qsHXAMAcPSbd3aK4cwJdGlDPSB2gQbCgR22ngWoq3oKUYe3CpX+3Q9r9MCF1GP6AeAooqxp8m+TSkOLZBIGv7MwQTt6Ka6SG2WHYMDo0TQD22BJL5MfS6kG5Yifcrjda+V5DFZApCfMWeyxRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hMNZhh3Q+Q0iINSFvyTaXjao3sluRWLjEuNBAJmNGF8=;
 b=SwWpCuZQ/pctoRy56Pez600kX6AHkJud5rnRVMzjt1KQkjBRCLsB+HQYo00FPDYgcxn5juL76rWl7TVcZh6upWZRMq7v+mRKjUxyu917xzLkwqR/qhthI2XtWjUy9qssOCSzM1HklUQzen4YroLOBnqjTlRYaND1Zb1DqS8/Bzg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from DM8PR01MB6824.prod.exchangelabs.com (2603:10b6:8:23::24) by
 DM6PR01MB5914.prod.exchangelabs.com (2603:10b6:5:14f::31) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5546.21; Wed, 24 Aug 2022 06:03:21 +0000
Received: from DM8PR01MB6824.prod.exchangelabs.com
 ([fe80::7058:9dd4:aa01:614a]) by DM8PR01MB6824.prod.exchangelabs.com
 ([fe80::7058:9dd4:aa01:614a%4]) with mapi id 15.20.5546.022; Wed, 24 Aug 2022
 06:03:21 +0000
From: Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
To: maz@kernel.org
Subject: [PATCH 3/3] KVM: arm64: nv: Avoid block mapping if max_map_size is
 smaller than block size.
Date: Tue, 23 Aug 2022 23:03:04 -0700
Message-Id: <20220824060304.21128-4-gankulkarni@os.amperecomputing.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20220824060304.21128-1-gankulkarni@os.amperecomputing.com>
References: <20220824060304.21128-1-gankulkarni@os.amperecomputing.com>
X-ClientProxiedBy: CH0P220CA0030.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:610:ef::28) To DM8PR01MB6824.prod.exchangelabs.com
 (2603:10b6:8:23::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dbd58d47-72c3-40da-9b9f-08da85965930
X-MS-TrafficTypeDiagnostic: DM6PR01MB5914:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 67r2G2I86q1d6W+od5N1MJSw7uNSyD0kfrKxU81lC9HCVj/W7oJ87d4BeAcuWXD/lEcpVp9NpUdNHx/tXswpG6S9WgBHYp0DixIT2/ornRqPP2Z7cmH31J+TJg25TaKeNoNJ1QLb+HUAnNCFOmafNkBulta2x5JehEM+hv4MUMQIFG1L00Bexi6MU/GN34331kCD4tL0TK2Plt6SxwKriTk0qUhhLfqvpjTr5pPrWTgXLCfH7RjjfOoqs/8ysUavGZ80Bzgx9dcG1El2K4I3CQ6fK5BRqLcFLX5kQDA6c2n+3GqvJtKZzDjIoALC20lNnS9KRjP11XpAIUqO7feObqyHMm593pWu+A1IfYBryflGOnLLyZ2pGCrX7NCjwHPjYwkEVIbbcMLfaGXEllTaenqP2PknxHXnymtbp+tdJVjHy9l6/YsF3eK6ZQvnNjIERM6LKS0SD2h1w9UXsXRRcJreWgDITH/auL2aDxx8AgspUhTM1P8UtaA5M6KtJV+e37iSC3ajhOTeX4PDxfLtom8739FCxFtRFz6qfFgeVWnKUt9EY3QBzZjobFAAVIIBGLC7CqHl+yBpLB3HtxDPgRyoCpqjREhTu7NIcQG6nabuOfPAfi0qzCu1FTR6pZYe2AVzYwdkK9JtlAHHBHCGm4NiPybNoFepbD1FVsTQ8ZOnumxjBeLPDdWT1jKrMkNAzYgltUJxsTskDbTJinLAQwbMoIP460fdlSFGyvNnmTG0Lw6rPPGws3witbKaovYKNwi8x1d/Fq/fnxCh4laCuA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR01MB6824.prod.exchangelabs.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(366004)(39850400004)(396003)(376002)(136003)(346002)(86362001)(38100700002)(38350700002)(6916009)(316002)(2906002)(8676002)(4326008)(66946007)(66556008)(8936002)(66476007)(5660300002)(2616005)(1076003)(41300700001)(478600001)(6512007)(186003)(26005)(107886003)(6666004)(52116002)(6506007)(6486002)(83380400001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JFXaUH0xGB98h60Qgs24NDf871Q6jUUiRgKLYBBoaeF5SoDVShjhcC6J7RqE?=
 =?us-ascii?Q?JDcm8Ci8jPF2q2fY7jbDdUPfrrlrfSkBcXC2D6EozfCIzMbpW+mA/A8GqeVt?=
 =?us-ascii?Q?tKfgR29OEAjsUhyf5djm7gZe7FUzSXl9HvVDJ06LQXZCu4qmxKiKViCm+N75?=
 =?us-ascii?Q?DzQ5HJOheGhU4bu151ljq1wLZIX4d4P6Dy8UjIu7dwaqHgJ0M7tOa8zevkB3?=
 =?us-ascii?Q?kw4nSlj7Iob/J6qbVgKcUDdqjvOAKPWxJBIL/Fy3kZ/NJJn1MwtXEGE7huWr?=
 =?us-ascii?Q?yrV14H/sTdUOyS7sY039kYb8bJA0waf4Vr5CDTPBeez4rdmY6F97v8bkzJOo?=
 =?us-ascii?Q?Ix48/77BhcSd1inEp32/4FgqegvYfochQylPYNGc5JNfZU3RXFKpIeKDAHHU?=
 =?us-ascii?Q?26GW+EAKyumerJj72K361AWk6rt/AHlBYh7A4QzTvxg0gqI/v0IafXeYIcyR?=
 =?us-ascii?Q?8bGawRDUFqoetQ6siFMGG9ZSC4jygIwZ5/CciQd1gQUgNuGNfiVsYbaaUByO?=
 =?us-ascii?Q?cwjmAmVW+dTCQkZ4IQUVIAGITE6kBIRD3yTsccSIL3DLdceDEGbgujk3nWFA?=
 =?us-ascii?Q?GGWOGBvWaog98jOvyqk5TFtNL2RkOx2u8zZ01mw3bwqnWjdoqoY4NdBLKCsv?=
 =?us-ascii?Q?EiUoQJe5TVDl3nTexP6oRHqg3YTVCRpOduKkoVQWvaAC1SkXsK4fnvkgTs8W?=
 =?us-ascii?Q?TKE85K2WwlD8IOy2ZXZElWnG54uJ5G6MO35mN7GYpL+XpMvwQkXc+u0Ihv4k?=
 =?us-ascii?Q?mCfsRnssGeK4YqFaSsjXneG8SPRQpQKJ4Uxt5AqIa1anxCYMtvG986ADJuxm?=
 =?us-ascii?Q?TSQ2hRkT0XnoDQ7Y0/NhY2bKaXKOVhMrLyDiQ+UuIiEtxDZ+ZfU/rfi1KQoc?=
 =?us-ascii?Q?fzhfG0SflW9/R7WT+6nGiLKlEBZd73jwHPxKh/jNKJdyXqw8VmbZHanPlvIW?=
 =?us-ascii?Q?GC4IaH1jHuB3KCdRqf1lxiFdONigDvK6yhUdKuQKtRTuXRMwzYcTALlCHEbr?=
 =?us-ascii?Q?8LaEUrNKoTb0qLbQjw9lC9q2rNgpKrtQA8GRtmA+YfY3H+T9FrR/0PkX7QzB?=
 =?us-ascii?Q?+UoKUOKmReoQIvJOhKbKvpx1wjP74/RzxZe3bziOQBkCyNYtY6KPDy4n8/0k?=
 =?us-ascii?Q?TCJgbMOUbq/lqxJJsj0SEPZ4ta7U7PukQt0hwzNQ8siWtLygoBvSZ9ghMu0s?=
 =?us-ascii?Q?FZEQtdyPsV2Gpvnv7pCQJn44pX1983fn5aPcieBhu99orQgEe/FU7HrJHRIK?=
 =?us-ascii?Q?nZmq38AQMUQyzc1Fjm+9+gyz5lzdu1cboKHRtk11O3bgYJ2qQRiqAjcAc/Ak?=
 =?us-ascii?Q?94RgT9XoL0WjAAzGmFqqymHqUPLtu28eI7iTxt8wFbun5G0uV9WZqv8lZymw?=
 =?us-ascii?Q?bP2bNx25/DtSUq11uCy0jR6kHM0ejqQ7Imd6wEVFb7B2tnuFOsiy4Ur9twnr?=
 =?us-ascii?Q?2QDRpqoMd+INVCPXSJdGyukmBabsfaLSeg5WVloeAGKFEYkXjDF0iYXSJp8h?=
 =?us-ascii?Q?N0NsfEZW49pJJ6wmO1/LPs900DtHFywEwQJBvqPwUQn649gPmfeTYIhZNtkT?=
 =?us-ascii?Q?VU2B8ViEk7GBmU8Av/CJZeCPnLSGkQQM77Gaxruzj7vr2Lg7Kz7JY3q5SfJ7?=
 =?us-ascii?Q?YA+ye9rsPt3S3yeOpcfF/XE=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbd58d47-72c3-40da-9b9f-08da85965930
X-MS-Exchange-CrossTenant-AuthSource: DM8PR01MB6824.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2022 06:03:21.5386 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: riBuPikBVx9Qkrpes0FCPxANvte0s90Li4F4F0dO8r4hKKsiLwig+jfo4oIcIaQKs4Fs7RaV5ouadys83ly7UtSnOTCtfShfxVKcFvy9U1boOdjBurh85KlDDf/HR/P2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR01MB5914
X-Mailman-Approved-At: Wed, 24 Aug 2022 11:52:40 -0400
Cc: scott@os.amperecomputing.com, kvm@vger.kernel.org, catalin.marinas@arm.com,
 keyur@os.amperecomputing.com, gankulkarni@os.amperecomputing.com,
 will@kernel.org, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org
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

In NV case, Shadow stage 2 page table is created using host hypervisor
page table configuration like page size, block size etc. Also, the shadow
stage 2 table uses block level mapping if the Guest Hypervisor IPA is
backed by the THP pages. However, this is resulting in illegal mapping of
NestedVM IPA to Host Hypervisor PA, when Guest Hypervisor and Host
hypervisor are configured with different pagesize.

Adding fix to avoid block level mapping in stage 2 mapping if
max_map_size is smaller than the block size.

Signed-off-by: Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
---
 arch/arm64/kvm/mmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index 6caa48da1b2e..3d4b53f153a1 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -1304,7 +1304,7 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 	 * backed by a THP and thus use block mapping if possible.
 	 */
 	if (vma_pagesize == PAGE_SIZE &&
-	    !(max_map_size == PAGE_SIZE || device)) {
+	    !(max_map_size < PMD_SIZE || device)) {
 		if (fault_status == FSC_PERM && fault_granule > PAGE_SIZE)
 			vma_pagesize = fault_granule;
 		else
-- 
2.33.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
