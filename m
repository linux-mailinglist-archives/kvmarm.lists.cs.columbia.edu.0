Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 5CDFF182CBD
	for <lists+kvmarm@lfdr.de>; Thu, 12 Mar 2020 10:52:32 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id E56A94A957;
	Thu, 12 Mar 2020 05:52:31 -0400 (EDT)
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
	with ESMTP id zLx1I20mLO5B; Thu, 12 Mar 2020 05:52:31 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id C5CD34A578;
	Thu, 12 Mar 2020 05:52:30 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 649704A49C
 for <kvmarm@lists.cs.columbia.edu>; Thu, 12 Mar 2020 05:52:29 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id E2gHHtiWOIqu for <kvmarm@lists.cs.columbia.edu>;
 Thu, 12 Mar 2020 05:52:28 -0400 (EDT)
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [207.211.31.120])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 1615D4A32E
 for <kvmarm@lists.cs.columbia.edu>; Thu, 12 Mar 2020 05:52:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584006747;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zG8vPwXr3fW379kNEBs9k2zxUAhuYclstIC5n/OmTcY=;
 b=b/vhPXqYYMPntaKThNrjs0cdotHtowm7mHi1sfI8pzgA2TkmRQ7LisHKFwWNsgvjb53S61
 hVTuRmZIfLTku29lMyMqfHMUaNbrFa4TZd+WVTFYf4W4S8G5UIdXy/5igSOaVlJ6r8TJe0
 f6vsYGjSxQ2bTlqcc7kDYyLEU34inDQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-175-0hKgPFkoNW-VDLxp0GcLmg-1; Thu, 12 Mar 2020 05:52:26 -0400
X-MC-Unique: 0hKgPFkoNW-VDLxp0GcLmg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5F1B7800D4E;
 Thu, 12 Mar 2020 09:52:24 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.43.2.160])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BBE8360BEC;
 Thu, 12 Mar 2020 09:52:22 +0000 (UTC)
Date: Thu, 12 Mar 2020 10:52:20 +0100
From: Andrew Jones <drjones@redhat.com>
To: Beata Michalska <beata.michalska@linaro.org>
Subject: Re: [PATCH v3 1/2] target/arm: kvm: Inject events at the last stage
 of sync
Message-ID: <20200312095220.bb6xdezdujufnfzg@kamzik.brq.redhat.com>
References: <20200312003401.29017-1-beata.michalska@linaro.org>
 <20200312003401.29017-2-beata.michalska@linaro.org>
MIME-Version: 1.0
In-Reply-To: <20200312003401.29017-2-beata.michalska@linaro.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, pbonzini@redhat.com,
 kvmarm@lists.cs.columbia.edu
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

On Thu, Mar 12, 2020 at 12:34:00AM +0000, Beata Michalska wrote:
> KVM_SET_VCPU_EVENTS might actually lead to vcpu registers being modified.
> As such this should be the last step of sync to avoid potential overwriting
> of whatever changes KVM might have done.
> 
> Signed-off-by: Beata Michalska <beata.michalska@linaro.org>
> ---
>  target/arm/kvm32.c | 15 ++++++++++-----
>  target/arm/kvm64.c | 15 ++++++++++-----
>  2 files changed, 20 insertions(+), 10 deletions(-)
>

Reviewed-by: Andrew Jones <drjones@redhat.com>

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
