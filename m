Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 8D509617CF7
	for <lists+kvmarm@lfdr.de>; Thu,  3 Nov 2022 13:46:40 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id C97254B64E;
	Thu,  3 Nov 2022 08:46:39 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.789
X-Spam-Level: 
X-Spam-Status: No, score=-1.789 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, T_DKIM_INVALID=0.01, URIBL_BLOCKED=0.001]
	autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@redhat.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YdIenbAbTD28; Thu,  3 Nov 2022 08:46:39 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 88F9F4B63B;
	Thu,  3 Nov 2022 08:46:38 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id B05384B0B9
 for <kvmarm@lists.cs.columbia.edu>; Thu,  3 Nov 2022 08:46:36 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sWLFbCaRH+9z for <kvmarm@lists.cs.columbia.edu>;
 Thu,  3 Nov 2022 08:46:35 -0400 (EDT)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 93B9A4A49C
 for <kvmarm@lists.cs.columbia.edu>; Thu,  3 Nov 2022 08:46:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1667479595;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6Lh+aq0KrT7YT7zq9EYFKfpsO05/wse1gFPTUN4LGR8=;
 b=OGcOkRMzvKi9W8TFAkyajOiurd/jzR3FxYOv+VxAk2Mp6OYk5SpPTnr0UJ6sCQPonK60+J
 /zM4YRqrcRWv24MKcrHyRIs3W/ByN6HuMSkCjWlHG5fS5EimZmyiWoMJAbzz6MECao+s8R
 voNDIw3orFR2OKtDjhryJQ4hxBCqr7k=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-425-rDTZzCaNMfqkeMoeZ1x5EQ-1; Thu, 03 Nov 2022 08:46:33 -0400
X-MC-Unique: rDTZzCaNMfqkeMoeZ1x5EQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 145AE823F77;
 Thu,  3 Nov 2022 12:46:31 +0000 (UTC)
Received: from localhost (unknown [10.39.193.104])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5E6A2492B06;
 Thu,  3 Nov 2022 12:46:30 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Marc Zyngier <maz@kernel.org>, Huacai Chen
 <chenhuacai@kernel.org>, Aleksandar Markovic
 <aleksandar.qemu.devel@gmail.com>, Anup Patel <anup@brainfault.org>, Paul
 Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Christian Borntraeger
 <borntraeger@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>, Matthew Rosato
 <mjrosato@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, Sean
 Christopherson <seanjc@google.com>, Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: Re: [PATCH 04/44] KVM: Teardown VFIO ops earlier in kvm_exit()
In-Reply-To: <20221102231911.3107438-5-seanjc@google.com>
Organization: Red Hat GmbH
References: <20221102231911.3107438-1-seanjc@google.com>
 <20221102231911.3107438-5-seanjc@google.com>
User-Agent: Notmuch/0.37 (https://notmuchmail.org)
Date: Thu, 03 Nov 2022 13:46:28 +0100
Message-ID: <87edukxl23.fsf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Cc: kvm@vger.kernel.org, David Hildenbrand <david@redhat.com>,
 Atish Patra <atishp@atishpatra.org>, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
 linux-s390@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>,
 Chao Gao <chao.gao@intel.com>, Yuan Yao <yuan.yao@intel.com>,
 kvmarm@lists.linux.dev, Thomas Gleixner <tglx@linutronix.de>,
 linux-arm-kernel@lists.infradead.org,
 Isaku Yamahata <isaku.yamahata@intel.com>,
 Fabiano Rosas <farosas@linux.ibm.com>, linux-mips@vger.kernel.org,
 kvm-riscv@lists.infradead.org, linuxppc-dev@lists.ozlabs.org
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

On Wed, Nov 02 2022, Sean Christopherson <seanjc@google.com> wrote:

> Move the call to kvm_vfio_ops_exit() further up kvm_exit() to try and
> bring some amount of symmetry to the setup order in kvm_init(), and more
> importantly so that the arch hooks are invoked dead last by kvm_exit().
> This will allow arch code to move away from the arch hooks without any
> change in ordering between arch code and common code in kvm_exit().
>
> That kvm_vfio_ops_exit() is called last appears to be 100% arbitrary.  It
> was bolted on after the fact by commit 571ee1b68598 ("kvm: vfio: fix
> unregister kvm_device_ops of vfio").  The nullified kvm_device_ops_table
> is also local to kvm_main.c and is used only when there are active VMs,
> so unless arch code is doing something truly bizarre, nullifying the
> table earlier in kvm_exit() is little more than a nop.
>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  virt/kvm/kvm_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Looks safe to me.

Reviewed-by: Cornelia Huck <cohuck@redhat.com>

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
