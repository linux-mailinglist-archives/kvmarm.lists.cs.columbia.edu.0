Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 4F0771D93A4
	for <lists+kvmarm@lfdr.de>; Tue, 19 May 2020 11:43:19 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id DF00D4B195;
	Tue, 19 May 2020 05:43:18 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.502
X-Spam-Level: 
X-Spam-Status: No, score=-1.502 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3,
	SPF_HELO_PASS=-0.001] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id utD0y4Flh91z; Tue, 19 May 2020 05:43:18 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id DCF434B188;
	Tue, 19 May 2020 05:43:17 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id D5A474B0E2
 for <kvmarm@lists.cs.columbia.edu>; Tue, 19 May 2020 05:43:16 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WAfuKS-SmOEt for <kvmarm@lists.cs.columbia.edu>;
 Tue, 19 May 2020 05:43:15 -0400 (EDT)
Received: from huawei.com (szxga05-in.huawei.com [45.249.212.191])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 583784B085
 for <kvmarm@lists.cs.columbia.edu>; Tue, 19 May 2020 05:43:15 -0400 (EDT)
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id E2957992080CA34DBE1F;
 Tue, 19 May 2020 17:43:11 +0800 (CST)
Received: from [127.0.0.1] (10.173.221.213) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.487.0;
 Tue, 19 May 2020 17:43:01 +0800
To: <linux-arm-kernel@lists.infradead.org>, <kvmarm@lists.cs.columbia.edu>
From: Xiang Zheng <zhengxiang9@huawei.com>
Subject: [RFC] Use SMMU HTTU for DMA dirty page tracking
Message-ID: <b926ec0b-fe87-0792-c41d-acad56c656a4@huawei.com>
Date: Tue, 19 May 2020 17:42:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
Content-Language: en-US
X-Originating-IP: [10.173.221.213]
X-CFilter-Loop: Reflected
Cc: jean-philippe@linaro.org, maz@kernel.org, wangzhou1@hisilicon.com,
 prime.zeng@hisilicon.com, Will Deacon <will@kernel.org>
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

Hi all,

Is there any plan for enabling SMMU HTTU?

I have seen the patch locates in the SVA series patch, which adds
support for HTTU:
    https://www.spinics.net/lists/arm-kernel/msg798694.html

HTTU reduces the number of access faults on SMMU fault queue
(permission faults also benifit from it).

Besides reducing the faults, HTTU also helps to track dirty pages for
device DMA. Is it feasible to utilize HTTU to get dirty pages on device
DMA during VFIO live migration?

If SMMU can track dirty pages, devices are not required to implement
additional dirty pages tracking to support VFIO live migration.

-- 
Thanks,
Xiang

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
