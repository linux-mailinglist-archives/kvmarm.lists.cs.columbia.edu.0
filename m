Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id D9291341BDC
	for <lists+kvmarm@lfdr.de>; Fri, 19 Mar 2021 12:57:31 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 6DE484B66E;
	Fri, 19 Mar 2021 07:57:31 -0400 (EDT)
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
	with ESMTP id n1vRtcoFxFOX; Fri, 19 Mar 2021 07:57:31 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 531C24B651;
	Fri, 19 Mar 2021 07:57:30 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 285A94B651
 for <kvmarm@lists.cs.columbia.edu>; Fri, 19 Mar 2021 07:57:28 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id W64I2SWx+UiN for <kvmarm@lists.cs.columbia.edu>;
 Fri, 19 Mar 2021 07:57:27 -0400 (EDT)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 35DDB4B615
 for <kvmarm@lists.cs.columbia.edu>; Fri, 19 Mar 2021 07:57:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1616155047;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rbAZp1REyqpJd0tlP5aJS8RZbdHhglDuIucuVAOLTes=;
 b=MgwrvLSuR9n3Hu8VDNwKxfwM6+NatN7XLCX507QOVYx28Keahv0D5N4njPCR3853KFIGx9
 IHXmOVdCOQC7RnGwZebhYKUe+ulPT5Rzjk55juz3ahChTb+MagPMVVA+kSMAOTlueUetXD
 pjFC62w/8COpPz6jyt8YiM+wJW/c7so=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-267-JsZI69VjO_6yvBQx2cCkww-1; Fri, 19 Mar 2021 07:57:25 -0400
X-MC-Unique: JsZI69VjO_6yvBQx2cCkww-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0DA6A81431F;
 Fri, 19 Mar 2021 11:57:24 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.40.192.242])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C432B6085A;
 Fri, 19 Mar 2021 11:57:22 +0000 (UTC)
Date: Fri, 19 Mar 2021 12:57:20 +0100
From: Andrew Jones <drjones@redhat.com>
To: Alexandru Elisei <alexandru.elisei@arm.com>
Subject: Re: [kvm-unit-tests PATCH v2] configure: arm/arm64: Add --earlycon
 option to set UART type and address
Message-ID: <20210319115720.vjuvi6rxebhyrdo7@kamzik.brq.redhat.com>
References: <20210318162022.84482-1-alexandru.elisei@arm.com>
 <20210318164157.xervbl23zvqmqdli@kamzik.brq.redhat.com>
 <d8403f28-c47c-d8eb-4131-c13a1fdd9a73@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <d8403f28-c47c-d8eb-4131-c13a1fdd9a73@arm.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Cc: pbonzini@redhat.com, kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org
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

On Fri, Mar 19, 2021 at 11:37:51AM +0000, Alexandru Elisei wrote:
> > You can also drop 'cut' and just do something like
> >
> > IFS=, read -r name type_addr addr <<<"$earlycon"
> 
> That looks much nicer and concise, and I prefer it to my approach.
> 
> However, I believe it requires a certain version of bash to work. On bash 5.1.4
> and 4.3.48 (copyright says it's from 2013), it works as expected. On bash 3.2.57
> (version used by MacOS), the result of the command is that the variable name
> contains the string with the comma replaced by space, and the other variables are
> empty. Using cut works with this version. According to the copyright notice, bash
> 3.2.57 is from 2007, so extremely old.
> 
> Did some googling for the query "bash split string" and according to this stack
> overflow question [1] (second reply), using IFS works for bash >= 4.2. Don't know
> how accurate it is.
> 
> I guess the question here is how compatible we want to be with regard to the bash
> version. I am not familiar with bash programming, so I will defer to your decision.

From time to time we've had this come up with kvm-unit-tests. The result
has always been to say "yeah, we should figure out our minimally required
Bash version and document that", but then we never do... It sounds like
you've identified Bash 4.2 being required for this IFS idiom. As we
already use this idiom in other places in kvm-unit-tests, then I think
the right thing to do is to test running all the current scripts with
Bash 4.2, and if that works, finally document it. I'll do that ASAP.

> > And/or should we do a quick sanity check on the address?
> > Something like
> >
> >   [[ $addr =~ ^0?x?[0-9a-f]+$ ]]
> 
> Another great suggestion. The pattern above doesn't take into account character
> case and the fact that 0xa is a valid number, but a is not. Best I could come up
> with is:
> 
> [[ $addr =~ ^0(x|X)[0-9a-fA-F]+$ ]] || [[ $addr =~ ^[0-9]+$ ]]
> 
> What do you think?

LGTM

Thanks,
drew

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
