Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id B4DF459FED8
	for <lists+kvmarm@lfdr.de>; Wed, 24 Aug 2022 17:52:45 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 1C1D44D2E4;
	Wed, 24 Aug 2022 11:52:45 -0400 (EDT)
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
	with ESMTP id J6SZ8V2jAw9l; Wed, 24 Aug 2022 11:52:43 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 5D3F24D301;
	Wed, 24 Aug 2022 11:52:42 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 9985B4C00C
 for <kvmarm@lists.cs.columbia.edu>; Wed, 24 Aug 2022 02:03:22 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hE5ITlDX4m04 for <kvmarm@lists.cs.columbia.edu>;
 Wed, 24 Aug 2022 02:03:21 -0400 (EDT)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2112.outbound.protection.outlook.com [40.107.93.112])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 517194C00E
 for <kvmarm@lists.cs.columbia.edu>; Wed, 24 Aug 2022 02:03:21 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NE+txOlWRiAJJVAuhs14BLwzD8afWx5IY6dgXnBo2qGoFOZoXguHvgPHIqlANj4kuqRJcg1xl2N9sC8R9wuzqpjbdj7NF6rvll9MVosP0M1S2Xh8TpNKZbLcIZ/5uNLlFwmmiIbTAy3kTNQCDpfJzA+vomfpe5HOd2+X0oe4NHCyMAeQLBdIhe7maOldpzS6Pq+Y5iIdYsRrq41RQCKbpiXi52T2mnb+aq4jHqz/YMcwi3OxivJudwZ5wAVepvQh95KeR4yNXq7LLDSEZzq6FkYLK7WMFLPIEUAU32ZP3AtWMdVGwVIRwjruoY9WVGq+vDWLyGBDRpdps5BtvZ+eCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4GI+nLH2hYI1BE5BBfDK5c8OIdM2maIvQks9FeJHJNs=;
 b=PBSGC6Lkg3mE3Rxs4THHKOYtADLRIxSEzej+Ja/rmU0MHHKcLuJwijHBU782j0bLOFpCOapqxr2+4YqW2jgb4Lgbpyd8REoqXgO3Q2dg+ck0jdiGjTBvBBxgU9R6ddnmG9JAGKPXWD/RPE9TuzSEDn4Uh5gYW2puYDsX4/rQIj20qv+qSlFk9v8I5j+R1F4HpchMOH6qdgHwHqE2PEVB+PXD7gAX4U/irPMzIfOdanMy6terEbc++HI7O6S7U23orPetYZnM9Ce4WZzeqAqD+1NYIEeUIGfZ2YS/fXfXXK2erMFlzwGtSzFOx2O0cTAizGHvMLxUF/FGxTlpDXdj8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4GI+nLH2hYI1BE5BBfDK5c8OIdM2maIvQks9FeJHJNs=;
 b=uEIh4yDOHFaMFA1HN/ZfbPUTpx3lhWJh1YdLdwLGYXujXDEYYdYUeZXu7GiBf4yduU0ukl/TugaAPTs94zsSHRkfwWIvZwfFnepeuyyUrzH66T3eVTgLZ3lB4WuVCyn9eJw3rvLAcRjLvVRBxmq23tjgJVEsGJaeWMi+4XeAju0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from DM8PR01MB6824.prod.exchangelabs.com (2603:10b6:8:23::24) by
 DM6PR01MB5914.prod.exchangelabs.com (2603:10b6:5:14f::31) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5546.21; Wed, 24 Aug 2022 06:03:20 +0000
Received: from DM8PR01MB6824.prod.exchangelabs.com
 ([fe80::7058:9dd4:aa01:614a]) by DM8PR01MB6824.prod.exchangelabs.com
 ([fe80::7058:9dd4:aa01:614a%4]) with mapi id 15.20.5546.022; Wed, 24 Aug 2022
 06:03:20 +0000
From: Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
To: maz@kernel.org
Subject: [PATCH 2/3] KVM: arm64: nv: Emulate ISTATUS when emulated timers are
 fired.
Date: Tue, 23 Aug 2022 23:03:03 -0700
Message-Id: <20220824060304.21128-3-gankulkarni@os.amperecomputing.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20220824060304.21128-1-gankulkarni@os.amperecomputing.com>
References: <20220824060304.21128-1-gankulkarni@os.amperecomputing.com>
X-ClientProxiedBy: CH0P220CA0030.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:610:ef::28) To DM8PR01MB6824.prod.exchangelabs.com
 (2603:10b6:8:23::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 73cc6139-db46-4d8f-a1e4-08da8596586b
X-MS-TrafficTypeDiagnostic: DM6PR01MB5914:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A3dm44bmCamI+RtBiPrPO9fmKmSuMqoeaJ6zYXRoRFS/HPfXKQV0RYe91lPwLpEWkrjf6jFK/5Vsfpdj6ffeeMe5DeA85X9v11stdwiJ1IwqJKwkkHshXUMG8oddau36L/PwG9F+ZKwNdQ/ijPj8ctTUpkFNTvGzSYCjQegLnyWZTdLVQOM38gJXcK90+PPjrjrs5B7oKumgh1W9nxrVi/Bwa3Lmc+qzHeV3mThHhJ3gjJMjYYP39VV8YYi2A5JEQlsUVSg2I9rlCbeoH0OuSyWPJO6Ong2vxQd/f99uIkuWRtsKMPN8NlOrhyNlxl51v9jRUfna2EqYyCZjHYa+R3OMKPq5N0ZD5xwL8veU5Eu0WFg/aZwa0CiAClnPW3zFyG8yHnDu5ukklMalBmvG/UYHYbfE8MFsnTVPIntj3XJAm9r2NKiG8W+u5vQEX3mUDwlm2rToFliPNZGq6xEq6nMH0olIvo9SQg0drvYjbdj2L2BoKEAvy2V94bT6z+xOtYLSwLw1cXyaw2zdA+cTfl65cU3hi/NI+Jmi6rJEoZRgR4p0FOmIMC/cWiPh1+M2xEIt+VroMy+2z+r87RO5uu5kTlIOoPEK8KyJsOwFKPIM66o4wN29+msgq0ic+MXEb85Hvzg5gL1O0kFiRWcdFS5/sKnwGzvdvmi/4BLwfVXwWXbodKADCC/N0JTNpQ8flmt1oGewEMi44gmjeR7Qqe0PQlbcMhYpRZ97XebBQ6EIreaSBEH/9EJYvLp80+dAh7kXbPsgN74aKrUIGlgZcw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR01MB6824.prod.exchangelabs.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(366004)(39850400004)(396003)(376002)(136003)(346002)(86362001)(38100700002)(38350700002)(6916009)(316002)(2906002)(8676002)(4326008)(66946007)(66556008)(8936002)(66476007)(5660300002)(2616005)(1076003)(41300700001)(478600001)(6512007)(186003)(26005)(107886003)(6666004)(52116002)(6506007)(6486002)(83380400001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6/rRiYdTavkf6rMwDC3ZJM5VEqdQx5whyokx+Blv/v333ue1f742GXgF9N/y?=
 =?us-ascii?Q?LRKBxuHMxBT1IJmDWH2isJezzuD5lc3hrIuYrleyHZhPIKHU5RkoydL+s7eR?=
 =?us-ascii?Q?ZvbNVjw7w+P0x3cbdaWu0ELnNr4/DxMVClMIQR182Tu/PeuswLTC2ehb1TNJ?=
 =?us-ascii?Q?1uEjmsqQ6m4K1neKwLdCWht6vNhatK/9GRcuCsUBBz3R9sCmgrLpZ+NecxK7?=
 =?us-ascii?Q?GugOsG9XX3u77qewbE/016NeSS6Mv3zk95dsIDUuemXrlrmwO+yrgoTFCBJt?=
 =?us-ascii?Q?WdfSI/Z2jbJVtmtUPYcYGpd27i3RmeJlVlYQKRkZCfGliB75Vduz3NDlGlZE?=
 =?us-ascii?Q?BEEXmzzgcHEVL6ucMQ/nsF0xVrK0PRWD+4/Dz1d4ZmwUciyiNaGGXxLyndxz?=
 =?us-ascii?Q?a400qVh1dHq8ZG+uuU0O/SvkTMc+rd7Q8MiCU5izg8UsfJ+0ITwF3xqf+i1+?=
 =?us-ascii?Q?DYNte2i7NjxatOUM9PNkfl+yyj/FGtIew13TdvBubeIfQK3BFNm9gBcHHUnj?=
 =?us-ascii?Q?pXXezAZwh2UIgciRpFsPP6/AEs0hHS5NI22LAMntMcOF+HQuO7/hBnTQ4O/Q?=
 =?us-ascii?Q?otui0FYJbAQlIAqJS13sFBczkERH2lwsIbXlJzDJInuC+a/oeWRCL9+LUh8O?=
 =?us-ascii?Q?mmBvc1SRtnp2fx28C+Y8nVP81uz8KmiDWcd+jcDmZe73LtYArnCdyMmCq+Tz?=
 =?us-ascii?Q?d7fNbC2McmeS93YdVPMw80fCCG/RYY/3/iY7/e7Dpxz/klX74wfiY2baPGbW?=
 =?us-ascii?Q?p7ehH1ug69a/KVpMRDexp0jitN7ykdtV7HSh6LjBYMo4t7RzwUl7+eFu7Bun?=
 =?us-ascii?Q?FzRtBb8lXZxd2ZlDrZBShyfPnMlEsqH2vhIbfBbNiruym/XtqKBqDM+Bw2zi?=
 =?us-ascii?Q?RloHVTAUsAZ9zJrX3/9jKZXqZWFlxvFzJMe4yMizj2JLujaGBHqhce97GoDF?=
 =?us-ascii?Q?HeVK8P9SjYQSuEGHBsYoAVYNGAnHS/q606sP1O4MNX8vKpqRqTaT8yTtu6v6?=
 =?us-ascii?Q?akT8NgeeQNuX0Hi3HSYCvXgYrC1nGhqpwkDf8nfvaBZcTzVj7eaMCpjVolI1?=
 =?us-ascii?Q?MH7tNvBZymMo9+WX/C8W/TNDq/g2F7qaWRZtT3REviKJ0PPmRnh3iNadrgCn?=
 =?us-ascii?Q?ur5Tet5D+lZO4TUO7i4Nh87gLLF7cb3Sn/Sc+1MaVcFwsdPBToT+a7/h3YHu?=
 =?us-ascii?Q?uPUyK/9bj9Zdc/a1M/YTdmPeQA+w9UCkghGjVakQ/dgOITRkSeVWLC3tv83k?=
 =?us-ascii?Q?gKhEivSYsdAskJY97xcFl+OZ21ZzHWCD2BE8s6l1lO++eKcl7XFxvgPuJdSX?=
 =?us-ascii?Q?XGoHAgBtBRK/6q8v4IAgodUYPLJyFnBkRhmqUfnZjnPrGg4nwl2zxdcO7z5j?=
 =?us-ascii?Q?0kQI1dVFO4u5d9B8mJwPI6XZ1jBMLfWO+UQDK/adws5XfFhFuBozf20idX6/?=
 =?us-ascii?Q?m6pY/bEzXZTqmVLWY/HjWDhBBvF1b5cYsucOFu6OPcK96w6VH+Zf5ge3w0eF?=
 =?us-ascii?Q?DZ0/88xRySFP1/4AcNlzgFG7s999+8JSAxRnu3jKef+rvLJbs/eDUFFifnVl?=
 =?us-ascii?Q?il0K9v/Er4RpU5qBOvXCfH5bYiH+QZXeht57qpcEzTDkgO4FXQCNmM3X/v33?=
 =?us-ascii?Q?U4y5w6ZwUGPz7wMqhZK+aUc=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73cc6139-db46-4d8f-a1e4-08da8596586b
X-MS-Exchange-CrossTenant-AuthSource: DM8PR01MB6824.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2022 06:03:20.2477 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8ZQVqfrz5C4Jrj6uvRV+wx7jzNbTYD+49kCahV3yG19jebTsUR4pGMieuw1WZ3Cr4X6ozYlOOhAGJFGPgsvXI2u349tkccXgK3JHdYicWmM0X+ZH+2WYLE/N0dnIxe9H
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

Guest-Hypervisor forwards the timer interrupt to Guest-Guest, if it is
enabled, unmasked and ISTATUS bit of register CNTV_CTL_EL0 is set for a
loaded timer.

For NV2 implementation, the Host-Hypervisor is not emulating the ISTATUS
bit while forwarding the Emulated Vtimer Interrupt to Guest-Hypervisor.
This results in the drop of interrupt from Guest-Hypervisor, where as
Host Hypervisor marked it as an active interrupt and expecting Guest-Guest
to consume and acknowledge. Due to this, some of the Guest-Guest vCPUs
are stuck in Idle thread and rcu soft lockups are seen.

This issue is not seen with NV1 case since the register CNTV_CTL_EL0 read
trap handler is emulating the ISTATUS bit.

Adding code to set/emulate the ISTATUS when the emulated timers are fired.

Signed-off-by: Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
---
 arch/arm64/kvm/arch_timer.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/kvm/arch_timer.c b/arch/arm64/kvm/arch_timer.c
index 27a6ec46803a..0b32d943d2d5 100644
--- a/arch/arm64/kvm/arch_timer.c
+++ b/arch/arm64/kvm/arch_timer.c
@@ -63,6 +63,7 @@ static u64 kvm_arm_timer_read(struct kvm_vcpu *vcpu,
 			      struct arch_timer_context *timer,
 			      enum kvm_arch_timer_regs treg);
 static bool kvm_arch_timer_get_input_level(int vintid);
+static u64 read_timer_ctl(struct arch_timer_context *timer);
 
 static struct irq_ops arch_timer_irq_ops = {
 	.get_input_level = kvm_arch_timer_get_input_level,
@@ -356,6 +357,8 @@ static enum hrtimer_restart kvm_hrtimer_expire(struct hrtimer *hrt)
 		return HRTIMER_RESTART;
 	}
 
+	/* Timer emulated, emulate ISTATUS also */
+	timer_set_ctl(ctx, read_timer_ctl(ctx));
 	kvm_timer_update_irq(vcpu, true, ctx);
 	return HRTIMER_NORESTART;
 }
@@ -458,6 +461,8 @@ static void timer_emulate(struct arch_timer_context *ctx)
 	trace_kvm_timer_emulate(ctx, should_fire);
 
 	if (should_fire != ctx->irq.level) {
+		/* Timer emulated, emulate ISTATUS also */
+		timer_set_ctl(ctx, read_timer_ctl(ctx));
 		kvm_timer_update_irq(ctx->vcpu, should_fire, ctx);
 		return;
 	}
-- 
2.33.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
