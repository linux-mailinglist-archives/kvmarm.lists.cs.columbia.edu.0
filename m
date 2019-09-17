Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 40267B4576
	for <lists+kvmarm@lfdr.de>; Tue, 17 Sep 2019 04:15:57 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id E53F14A68D;
	Mon, 16 Sep 2019 22:15:55 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.502
X-Spam-Level: 
X-Spam-Status: No, score=-1.502 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3,
	SPF_HELO_PASS=-0.001] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8BuWjv8ml+Tx; Mon, 16 Sep 2019 22:15:55 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id DC5524A665;
	Mon, 16 Sep 2019 22:15:54 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id F1B8A4A5CF
 for <kvmarm@lists.cs.columbia.edu>; Mon, 16 Sep 2019 22:15:53 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DXarSt17tLzd for <kvmarm@lists.cs.columbia.edu>;
 Mon, 16 Sep 2019 22:15:52 -0400 (EDT)
Received: from huawei.com (szxga04-in.huawei.com [45.249.212.190])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 65C084A5C4
 for <kvmarm@lists.cs.columbia.edu>; Mon, 16 Sep 2019 22:15:52 -0400 (EDT)
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 5B4ADCE8CECF440A3F7E;
 Tue, 17 Sep 2019 10:15:49 +0800 (CST)
Received: from [127.0.0.1] (10.74.221.148) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.439.0; Tue, 17 Sep 2019
 10:15:42 +0800
To: <linux-arm-kernel@lists.infradead.org>, <kvmarm@lists.cs.columbia.edu>
From: Shaokun Zhang <zhangshaokun@hisilicon.com>
Subject: [Question-GIC-v4.1] Plan on GIC-v4.1 driver development
Message-ID: <40d7276c-54a3-0cca-a207-217459850c21@hisilicon.com>
Date: Tue, 17 Sep 2019 10:15:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.1.1
MIME-Version: 1.0
X-Originating-IP: [10.74.221.148]
X-CFilter-Loop: Reflected
Cc: Marc Zyngier <maz@kernel.org>
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

Hi Marc,

This is from Nianyao Tang.

I'm planning to do some verification on our GIC-v4.1 implement. I would like some
information about linux GIC-v4.1 driver. When will linux support GIC-v4.1 or what's
the plan on developing GIC-v4.1 driver?

Thanks,
Nianyao.

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
