Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id BB30F10C5DA
	for <lists+kvmarm@lfdr.de>; Thu, 28 Nov 2019 10:20:26 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 526C24ACF5;
	Thu, 28 Nov 2019 04:20:26 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zVN+ppn7kF7K; Thu, 28 Nov 2019 04:20:26 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 3DCE84A946;
	Thu, 28 Nov 2019 04:20:25 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id B9C244A59B
 for <kvmarm@lists.cs.columbia.edu>; Thu, 28 Nov 2019 04:20:23 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8ORommpKRq94 for <kvmarm@lists.cs.columbia.edu>;
 Thu, 28 Nov 2019 04:20:22 -0500 (EST)
Received: from huawei.com (szxga08-in.huawei.com [45.249.212.255])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 816664A597
 for <kvmarm@lists.cs.columbia.edu>; Thu, 28 Nov 2019 04:20:22 -0500 (EST)
Received: from DGGEMM405-HUB.china.huawei.com (unknown [172.30.72.57])
 by Forcepoint Email with ESMTP id 372C97DF42E69E39CF90;
 Thu, 28 Nov 2019 17:20:19 +0800 (CST)
Received: from dggeme713-chm.china.huawei.com (10.1.199.109) by
 DGGEMM405-HUB.china.huawei.com (10.3.20.213) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 28 Nov 2019 17:20:18 +0800
Received: from dggeme763-chm.china.huawei.com (10.3.19.109) by
 dggeme713-chm.china.huawei.com (10.1.199.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1713.5; Thu, 28 Nov 2019 17:20:18 +0800
Received: from dggeme763-chm.china.huawei.com ([10.6.66.36]) by
 dggeme763-chm.china.huawei.com ([10.6.66.36]) with mapi id 15.01.1713.004;
 Thu, 28 Nov 2019 17:20:18 +0800
From: linmiaohe <linmiaohe@huawei.com>
To: Auger Eric <eric.auger@redhat.com>, "maz@kernel.org" <maz@kernel.org>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "rkrcmar@redhat.com"
 <rkrcmar@redhat.com>, "james.morse@arm.com" <james.morse@arm.com>,
 "julien.thierry.kdev@gmail.com" <julien.thierry.kdev@gmail.com>,
 "suzuki.poulose@arm.com" <suzuki.poulose@arm.com>, "christoffer.dall@arm.com"
 <christoffer.dall@arm.com>, "catalin.marinas@arm.com"
 <catalin.marinas@arm.com>, "gregkh@linuxfoundation.org"
 <gregkh@linuxfoundation.org>, "will@kernel.org" <will@kernel.org>,
 "andre.przywara@arm.com" <andre.przywara@arm.com>, "tglx@linutronix.de"
 <tglx@linutronix.de>
Subject: Re: [PATCH] KVM: vgic: Use warpper function to lock/unlock all vcpus
 in kvm_vgic_create()
Thread-Topic: [PATCH] KVM: vgic: Use warpper function to lock/unlock all vcpus
 in kvm_vgic_create()
Thread-Index: AdWly9EF1J/EpZSsQNGjM4qqDvLl/w==
Date: Thu, 28 Nov 2019 09:20:18 +0000
Message-ID: <ba063b6de6b14fedb09c9d382120bf46@huawei.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.184.189.20]
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
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

Eric wrote:
>> From: Miaohe Lin <linmiaohe@huawei.com>
>> 
>> Use warpper function lock_all_vcpus()/unlock_all_vcpus()
> s/warpper/wrapper and also in the title.

Hi, Eric:
Many thanks for your review. I would fix this and send a patch v2.
Thanks again.
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
