Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 4EC9A126E2E
	for <lists+kvmarm@lfdr.de>; Thu, 19 Dec 2019 20:47:52 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id D0CF64A8E8;
	Thu, 19 Dec 2019 14:47:51 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.391
X-Spam-Level: 
X-Spam-Status: No, score=-1.391 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3,
	T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@redhat.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UATm7-blpsDu; Thu, 19 Dec 2019 14:47:51 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id C6CA84A650;
	Thu, 19 Dec 2019 14:47:50 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id C74A64A5A6
 for <kvmarm@lists.cs.columbia.edu>; Thu, 19 Dec 2019 14:47:49 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8EpFl6T3hnNH for <kvmarm@lists.cs.columbia.edu>;
 Thu, 19 Dec 2019 14:47:48 -0500 (EST)
Received: from us-smtp-delivery-1.mimecast.com
 (us-smtp-delivery-1.mimecast.com [205.139.110.120])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id BFAD14A5A3
 for <kvmarm@lists.cs.columbia.edu>; Thu, 19 Dec 2019 14:47:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576784868;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7s8aSCvp52Fcz2Wx/tS6wh/olyKy8a3YGMnOjn2uv8E=;
 b=KxYT5OwG6aazsdc6iH1JX2B+zsw1tJNHBss9X0G3QLQo+t8RYy/AuwVzSFfhDJiXfuW2v9
 +1hVX51fB3zj1kL9bkmX9mUvhlM0IMo6QJzwc1jq2iXk536f0xGIC6iNn2s8Dxc27UNvs3
 wUwbRa0iCiEIEkPv6YiSuisXAILwV0w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-198--uvnZKzHMz6b8tS9keq1SQ-1; Thu, 19 Dec 2019 14:47:46 -0500
X-MC-Unique: -uvnZKzHMz6b8tS9keq1SQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 30A4C1856A60;
 Thu, 19 Dec 2019 19:47:44 +0000 (UTC)
Received: from gondolin (ovpn-117-134.ams2.redhat.com [10.36.117.134])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7E3D610021B2;
 Thu, 19 Dec 2019 19:47:36 +0000 (UTC)
Date: Thu, 19 Dec 2019 20:47:33 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Sean Christopherson <sean.j.christopherson@intel.com>
Subject: Re: [PATCH v2 26/45] KVM: s390: Invoke kvm_vcpu_init() before
 allocating sie_page
Message-ID: <20191219204733.791f7380.cohuck@redhat.com>
In-Reply-To: <20191218215530.2280-27-sean.j.christopherson@intel.com>
References: <20191218215530.2280-1-sean.j.christopherson@intel.com>
 <20191218215530.2280-27-sean.j.christopherson@intel.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Cc: Wanpeng Li <wanpengli@tencent.com>, Janosch Frank <frankja@linux.ibm.com>,
 kvm@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
 Joerg Roedel <joro@8bytes.org>, David Hildenbrand <david@redhat.com>,
 linux-mips@vger.kernel.org, kvm-ppc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Paul Mackerras <paulus@ozlabs.org>,
 Christian Borntraeger <borntraeger@de.ibm.com>, Greg Kurz <groug@kaod.org>,
 linux-arm-kernel@lists.infradead.org, James Hogan <jhogan@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>,
 kvmarm@lists.cs.columbia.edu, Jim Mattson <jmattson@google.com>
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

On Wed, 18 Dec 2019 13:55:11 -0800
Sean Christopherson <sean.j.christopherson@intel.com> wrote:

> Now that s390's implementation of kvm_arch_vcpu_init() is empty, move
> the call to kvm_vcpu_init() above the allocation of the sie_page.  This
> paves the way for moving vcpu allocation and initialization into common
> KVM code without any associated functional change.
> 
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> ---
>  arch/s390/kvm/kvm-s390.c | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)

Seems to be fine.

Reviewed-by: Cornelia Huck <cohuck@redhat.com>

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
