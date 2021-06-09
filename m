Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 971D93A19EE
	for <lists+kvmarm@lfdr.de>; Wed,  9 Jun 2021 17:38:01 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 0710D49E8A;
	Wed,  9 Jun 2021 11:38:01 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.209
X-Spam-Level: 
X-Spam-Status: No, score=0.209 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_LOW=-0.7,
	T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@redhat.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id K9hb1tfL8C4k; Wed,  9 Jun 2021 11:38:00 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id DE44540CF9;
	Wed,  9 Jun 2021 11:37:59 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 4B9FB40874
 for <kvmarm@lists.cs.columbia.edu>; Wed,  9 Jun 2021 11:37:58 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Vyegadrshy8k for <kvmarm@lists.cs.columbia.edu>;
 Wed,  9 Jun 2021 11:37:57 -0400 (EDT)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 68E8D407EF
 for <kvmarm@lists.cs.columbia.edu>; Wed,  9 Jun 2021 11:37:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1623253077;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aoPcTEuzpei3fqr/p6OooHtZD65GcAITgVzjPSwm+HY=;
 b=UJ8EmMvFzN2inwkFBO7zXo7ke34xqn1YJ/AdSJwIB9NcaRTNRURy+8+yMT7CaISSdxqjGi
 6caYTszpd+vodQ1bLsUPKC66h/hZfgrGXhAF/ZF6WHLPvTyhgR/Gl6MdYCe7Gq0ld3gKwZ
 XqQX3AUmIfj09GKfIy0HiFMuqk9NB0g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-527-G0yU6th6OIe9agOZauWL6A-1; Wed, 09 Jun 2021 11:37:56 -0400
X-MC-Unique: G0yU6th6OIe9agOZauWL6A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B9E21800D62;
 Wed,  9 Jun 2021 15:37:54 +0000 (UTC)
Received: from localhost (ovpn-113-134.ams2.redhat.com [10.36.113.134])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1986F60CCC;
 Wed,  9 Jun 2021 15:37:50 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>, Andrew Jones
 <drjones@redhat.com>
Subject: Re: [kvm-unit-tests PATCH v2 2/7] lib: unify header guards
In-Reply-To: <f20b32d0-9272-66d5-e106-a0af4340b95a@redhat.com>
Organization: Red Hat GmbH
References: <20210609143712.60933-1-cohuck@redhat.com>
 <20210609143712.60933-3-cohuck@redhat.com>
 <f20b32d0-9272-66d5-e106-a0af4340b95a@redhat.com>
User-Agent: Notmuch/0.32.1 (https://notmuchmail.org)
Date: Wed, 09 Jun 2021 17:37:49 +0200
Message-ID: <877dj3122a.fsf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Cc: linux-s390@vger.kernel.org, Janosch Frank <frankja@linux.ibm.com>,
 kvm@vger.kernel.org, David Hildenbrand <david@redhat.com>,
 kvm-ppc@vger.kernel.org, Claudio Imbrenda <imbrenda@linux.ibm.com>,
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

On Wed, Jun 09 2021, Laurent Vivier <lvivier@redhat.com> wrote:

> On 09/06/2021 16:37, Cornelia Huck wrote:
>> Standardize header guards to _LIB_HEADER_H_.
>> 
>> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
>> ---
>>  lib/alloc_page.h       | 4 ++--
>>  lib/libcflat.h         | 4 ++--
>>  lib/list.h             | 4 ++--
>>  lib/pci-edu.h          | 4 ++--
>>  lib/pci-host-generic.h | 4 ++--
>>  lib/setjmp.h           | 4 ++--
>>  lib/string.h           | 6 +++---
>>  lib/vmalloc.h          | 4 ++--
>>  8 files changed, 17 insertions(+), 17 deletions(-)
>
> What about lib/argv.h and lib/pci.h?

argv.h does not have a header guard yet (it probably should?)

I forgot to commit my changes to pci.h, I think :(

>
> And there is also this instance of CONFIG_H in lib/config.h generated
> by configure.

Yeah, we should tweak the generator for that.

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
