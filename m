Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 80F862CEC12
	for <lists+kvmarm@lfdr.de>; Fri,  4 Dec 2020 11:22:25 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 1A2D34B15F;
	Fri,  4 Dec 2020 05:22:25 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AoR3ybA-ZO6r; Fri,  4 Dec 2020 05:22:25 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id D0C654B144;
	Fri,  4 Dec 2020 05:22:23 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 50E024B12D
 for <kvmarm@lists.cs.columbia.edu>; Fri,  4 Dec 2020 05:22:23 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lPiMKaqi4c3A for <kvmarm@lists.cs.columbia.edu>;
 Fri,  4 Dec 2020 05:22:21 -0500 (EST)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id B251F4B11F
 for <kvmarm@lists.cs.columbia.edu>; Fri,  4 Dec 2020 05:22:20 -0500 (EST)
Received: from DGGEMM405-HUB.china.huawei.com (unknown [172.30.72.55])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4CnTJv5JjDzQndf;
 Fri,  4 Dec 2020 18:21:51 +0800 (CST)
Received: from dggemi753-chm.china.huawei.com (10.1.198.139) by
 DGGEMM405-HUB.china.huawei.com (10.3.20.213) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Fri, 4 Dec 2020 18:20:30 +0800
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 dggemi753-chm.china.huawei.com (10.1.198.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Fri, 4 Dec 2020 18:20:29 +0800
Received: from lhreml710-chm.china.huawei.com ([169.254.81.184]) by
 lhreml710-chm.china.huawei.com ([169.254.81.184]) with mapi id
 15.01.1913.007; Fri, 4 Dec 2020 10:20:27 +0000
From: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: RE: [PATCH v13 07/15] iommu/smmuv3: Allow stage 1 invalidation with
 unmanaged ASIDs
Thread-Topic: [PATCH v13 07/15] iommu/smmuv3: Allow stage 1 invalidation with
 unmanaged ASIDs
Thread-Index: AQHWvZ36CODK3kmCyk2T9hmchYhCqqniWTe/gANqCPCAAQgyAIAABi8Q
Date: Fri, 4 Dec 2020 10:20:26 +0000
Message-ID: <2de03a797517452cbfeab022e12612b7@huawei.com>
References: <20201118112151.25412-8-eric.auger@redhat.com>
 <1606829590-25924-1-git-send-email-wangxingang5@huawei.com>
 <2e69adf5-8207-64f7-fa8e-9f2bd3a3c4e3@redhat.com>
 <e10ad90dc5144c0d9df98a9a078091af@huawei.com>
 <20201204095338.GA1912466@myrica>
In-Reply-To: <20201204095338.GA1912466@myrica>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.200.67.145]
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Cc: Xieyingtai <xieyingtai@huawei.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 wangxingang <wangxingang5@huawei.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "vivek.gautam@arm.com" <vivek.gautam@arm.com>,
 "maz@kernel.org" <maz@kernel.org>, "joro@8bytes.org" <joro@8bytes.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 qubingbing <qubingbing@hisilicon.com>,
 "Zengtao \(B\)" <prime.zeng@hisilicon.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>,
 "will@kernel.org" <will@kernel.org>,
 "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>
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

Hi Jean,

> -----Original Message-----
> From: Jean-Philippe Brucker [mailto:jean-philippe@linaro.org]
> Sent: 04 December 2020 09:54
> To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
> Cc: Auger Eric <eric.auger@redhat.com>; wangxingang
> <wangxingang5@huawei.com>; Xieyingtai <xieyingtai@huawei.com>;
> kvm@vger.kernel.org; maz@kernel.org; joro@8bytes.org; will@kernel.org;
> iommu@lists.linux-foundation.org; linux-kernel@vger.kernel.org;
> vivek.gautam@arm.com; alex.williamson@redhat.com;
> zhangfei.gao@linaro.org; robin.murphy@arm.com;
> kvmarm@lists.cs.columbia.edu; eric.auger.pro@gmail.com; Zengtao (B)
> <prime.zeng@hisilicon.com>; qubingbing <qubingbing@hisilicon.com>
> Subject: Re: [PATCH v13 07/15] iommu/smmuv3: Allow stage 1 invalidation with
> unmanaged ASIDs
> 
> Hi Shameer,
> 
> On Thu, Dec 03, 2020 at 06:42:57PM +0000, Shameerali Kolothum Thodi wrote:
> > Hi Jean/zhangfei,
> > Is it possible to have a branch with minimum required SVA/UACCE related
> patches
> > that are already public and can be a "stable" candidate for future respin of
> Eric's series?
> > Please share your thoughts.
> 
> By "stable" you mean a fixed branch with the latest SVA/UACCE patches
> based on mainline? 

Yes. 

 The uacce-devel branches from
> https://github.com/Linaro/linux-kernel-uadk do provide this at the moment
> (they track the latest sva/zip-devel branch
> https://jpbrucker.net/git/linux/ which is roughly based on mainline.)

Thanks. 

Hi Eric,

Could you please take a look at the above branches and see whether it make sense
to rebase on top of either of those?

From vSVA point of view, it will be less rebase hassle if we can do that.

Thanks,
Shameer

> Thanks,
> Jean

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
