Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id C8F8913AC25
	for <lists+kvmarm@lfdr.de>; Tue, 14 Jan 2020 15:21:13 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 2A2354B04A;
	Tue, 14 Jan 2020 09:21:13 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.502
X-Spam-Level: 
X-Spam-Status: No, score=-1.502 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3,
	SPF_HELO_PASS=-0.001] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tfDvl6HoqkBp; Tue, 14 Jan 2020 09:21:13 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 6E7174B032;
	Tue, 14 Jan 2020 09:21:08 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 7D7454AFB8
 for <kvmarm@lists.cs.columbia.edu>; Tue, 14 Jan 2020 09:21:06 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bmdah23n8uXK for <kvmarm@lists.cs.columbia.edu>;
 Tue, 14 Jan 2020 09:21:01 -0500 (EST)
Received: from huawei.com (szxga05-in.huawei.com [45.249.212.191])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 59B004AF4F
 for <kvmarm@lists.cs.columbia.edu>; Tue, 14 Jan 2020 09:21:01 -0500 (EST)
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 305A29FA6ADF3375DD5C;
 Tue, 14 Jan 2020 22:20:57 +0800 (CST)
Received: from [127.0.0.1] (10.74.221.148) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.439.0; Tue, 14 Jan 2020
 22:20:48 +0800
To: Marc Zyngier <maz@kernel.org>, "Tangnianyao (ICT)"
 <tangnianyao@huawei.com>, <kvmarm@lists.cs.columbia.edu>,
 <linux-arm-kernel@lists.infradead.org>, <fanhenglong@huawei.com>,
 <wanghaibin.wang@huawei.com>
From: Shaokun Zhang <zhangshaokun@hisilicon.com>
Subject: [Question about KVM on arm64] Consider putting VINVALL to deactivation
Message-ID: <bf470803-8e1c-d1c3-d5ac-731536196543@hisilicon.com>
Date: Tue, 14 Jan 2020 22:20:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.1.1
MIME-Version: 1.0
X-Originating-IP: [10.74.221.148]
X-CFilter-Loop: Reflected
Cc: Lizixian <lizixian@hisilicon.com>, wangwudi <wangwudi@hisilicon.com>,
 jiayanlei@huawei.com
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

On activation, VMAPP command is followed by a VINVALL, which could be quite expensive
for the start-up of virtual machine. If a vpeid is allowed successfully, it is not
used in system. We may consider put VINVALL to deactivation to ensure all cache of
certain vpeid is invalid, to simplify activation. We consider start-up may be more
common and more time-consuming-sensitive than shutdown process.

Do you think it's all right?

Thanks,
Shaokun

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
