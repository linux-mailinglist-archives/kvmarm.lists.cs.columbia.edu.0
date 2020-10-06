Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id C1A7F284EFB
	for <lists+kvmarm@lfdr.de>; Tue,  6 Oct 2020 17:29:39 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 51F074B976;
	Tue,  6 Oct 2020 11:29:39 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.909
X-Spam-Level: 
X-Spam-Status: No, score=0.909 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699,
	RCVD_IN_DNSWL_NONE=-0.0001, T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@redhat.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ds6D-3H-m-Qd; Tue,  6 Oct 2020 11:29:39 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 46B6E4B981;
	Tue,  6 Oct 2020 11:29:38 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id DAF444B835
 for <kvmarm@lists.cs.columbia.edu>; Tue,  6 Oct 2020 11:29:36 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lOvndFNLn158 for <kvmarm@lists.cs.columbia.edu>;
 Tue,  6 Oct 2020 11:29:36 -0400 (EDT)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 09B0A4B808
 for <kvmarm@lists.cs.columbia.edu>; Tue,  6 Oct 2020 11:29:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601998175;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b3TQyn0r0hHJtyWnHzP2XsiJelQMbh2EnW4oVHas18k=;
 b=L4a7KgpJqlF5Frn19gxbj/K2uMtGqZksQXEvwofgg+OWuxk6H5/wq5tjmOX0To3lqXKdDc
 CANrqDFg/dAiLBsfy1V+yB/m68FI1H1AvfInVmKU4IVZfpQaT0eGHQUrpOy/kHzX5o26dA
 Du4bTRhtDYns2tFdyO2AqUUCgWz0BxI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-557-XNZ3tFqAPmCyxpBT5oD_sA-1; Tue, 06 Oct 2020 11:29:31 -0400
X-MC-Unique: XNZ3tFqAPmCyxpBT5oD_sA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7226018A072C;
 Tue,  6 Oct 2020 15:29:29 +0000 (UTC)
Received: from [10.36.113.210] (ovpn-113-210.ams2.redhat.com [10.36.113.210])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9C32255764;
 Tue,  6 Oct 2020 15:29:23 +0000 (UTC)
Subject: Re: [PATCH v10 11/11] vfio: Document nested stage control
To: Zenghui Yu <yuzenghui@huawei.com>, eric.auger.pro@gmail.com,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu, joro@8bytes.org,
 alex.williamson@redhat.com, jacob.jun.pan@linux.intel.com,
 yi.l.liu@intel.com, robin.murphy@arm.com
References: <20200320161911.27494-1-eric.auger@redhat.com>
 <20200320161911.27494-12-eric.auger@redhat.com>
 <26a85a63-6cc1-0348-e703-cb31ddd75339@huawei.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <4df9f189-7a1b-be1f-0b1a-1669534a98d7@redhat.com>
Date: Tue, 6 Oct 2020 17:29:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <26a85a63-6cc1-0348-e703-cb31ddd75339@huawei.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
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

Hi Zenghui,

On 9/24/20 3:42 PM, Zenghui Yu wrote:
> Hi Eric,
> 
> On 2020/3/21 0:19, Eric Auger wrote:
>> The VFIO API was enhanced to support nested stage control: a bunch of
>> new iotcls, one DMA FAULT region and an associated specific IRQ.
>>
>> Let's document the process to follow to set up nested mode.
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> 
> [...]
> 
>> +The userspace must be prepared to receive faults. The VFIO-PCI device
>> +exposes one dedicated DMA FAULT region: it contains a ring buffer and
>> +its header that allows to manage the head/tail indices. The region is
>> +identified by the following index/subindex:
>> +- VFIO_REGION_TYPE_NESTED/VFIO_REGION_SUBTYPE_NESTED_DMA_FAULT
>> +
>> +The DMA FAULT region exposes a VFIO_REGION_INFO_CAP_PRODUCER_FAULT
>> +region capability that allows the userspace to retrieve the ABI version
>> +of the fault records filled by the host.
> 
> Nit: I don't see this capability in the code.

Thank you very much for the review. I am late doing the respin but I
will take into account all your comments.

Thanks!

Eric
> 
> 
> Thanks,
> Zenghui
> 

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
