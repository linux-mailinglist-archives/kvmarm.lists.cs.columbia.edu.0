Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id D66C026D593
	for <lists+kvmarm@lfdr.de>; Thu, 17 Sep 2020 10:04:44 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 6A4664B818;
	Thu, 17 Sep 2020 04:04:44 -0400 (EDT)
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
	with ESMTP id GwzVWIljNqct; Thu, 17 Sep 2020 04:04:44 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 4D32D4B814;
	Thu, 17 Sep 2020 04:04:43 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id A41E54B7FD
 for <kvmarm@lists.cs.columbia.edu>; Thu, 17 Sep 2020 04:04:41 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JPFa8EM846Nh for <kvmarm@lists.cs.columbia.edu>;
 Thu, 17 Sep 2020 04:04:40 -0400 (EDT)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id BDA844B7FC
 for <kvmarm@lists.cs.columbia.edu>; Thu, 17 Sep 2020 04:04:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600329880;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2KPrQh5EWErmHM86gwG9SLynueQ4HadaDegVq2gjLUI=;
 b=ca/r/7CthbEYc5RtY666UBnpbbyqPf2fKblk/qOdN+RtKWAlugYI8ubGdGh0NfjFDht3n7
 dlscb00uPGIstywkRmLw05Wa2tuF/viVIQd74B/ewfZ79DnOZUe/VYek4LdMRyDE7AwK9Y
 1RyE4Stbx4rxJG+StNPWvRelgdiBDJ0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-212-2PYnQhV6PN6MlWP3Yq4itA-1; Thu, 17 Sep 2020 04:04:36 -0400
X-MC-Unique: 2PYnQhV6PN6MlWP3Yq4itA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0C76185C733;
 Thu, 17 Sep 2020 08:04:35 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.40.192.179])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A3021101416C;
 Thu, 17 Sep 2020 08:04:32 +0000 (UTC)
Date: Thu, 17 Sep 2020 10:04:29 +0200
From: Andrew Jones <drjones@redhat.com>
To: Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH 2/2] kvm/arm: Add mp_affinity for arm vcpu
Message-ID: <20200917080429.jimidzdtdskwhbdx@kamzik.brq.redhat.com>
References: <20200917023033.1337-1-fangying1@huawei.com>
 <20200917023033.1337-3-fangying1@huawei.com>
 <7a924b0fb27505a0d8b00389fe2f02df@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <7a924b0fb27505a0d8b00389fe2f02df@kernel.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Cc: zhang.zhanghailiang@huawei.com, kvm@vger.kernel.org, alex.chen@huawei.com,
 Ying Fang <fangying1@huawei.com>, kvmarm@lists.cs.columbia.edu
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

On Thu, Sep 17, 2020 at 08:47:42AM +0100, Marc Zyngier wrote:
> On 2020-09-17 03:30, Ying Fang wrote:
> > Allow userspace to set MPIDR using vcpu ioctl KVM_ARM_SET_MP_AFFINITY,
> > so that we can support cpu topology for arm.
> 
> MPIDR has *nothing* to do with CPU topology in the ARM architecture.
> I encourage you to have a look at the ARM ARM and find out how often
> the word "topology" is used in conjunction with the MPIDR_EL1 register.
>

Hi Marc,

I mostly agree. However, the CPU topology descriptions use MPIDR to
identify PEs. If userspace wants to build topology descriptions then
it either needs to

1) build them after instantiating all KVM VCPUs in order to query KVM
   for each MPIDR, or
2) have a way to ask KVM for an MPIDR of given VCPU ID in advance
   (maybe just a scratch VCPU), or
3) have control over the MPIDRs so it can choose them when it likes,
   use them for topology descriptions, and then instantiate KVM VCPUs
   with them.

I think (3) is the most robust approach, and it has the least overhead.

Thanks,
drew

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
