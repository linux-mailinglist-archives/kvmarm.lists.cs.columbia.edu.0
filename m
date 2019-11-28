Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id ABB9C10CC03
	for <lists+kvmarm@lfdr.de>; Thu, 28 Nov 2019 16:45:39 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 4A4834ACF4;
	Thu, 28 Nov 2019 10:45:39 -0500 (EST)
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
	with ESMTP id crfjqk8n23gp; Thu, 28 Nov 2019 10:45:39 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 293364ACB7;
	Thu, 28 Nov 2019 10:45:38 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 9F4664A97D
 for <kvmarm@lists.cs.columbia.edu>; Thu, 28 Nov 2019 10:45:36 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DiVmJDparjBi for <kvmarm@lists.cs.columbia.edu>;
 Thu, 28 Nov 2019 10:45:35 -0500 (EST)
Received: from us-smtp-1.mimecast.com (us-smtp-2.mimecast.com [205.139.110.61])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id B06254A54B
 for <kvmarm@lists.cs.columbia.edu>; Thu, 28 Nov 2019 10:45:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574955935;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xGsdSO+ydrVZSxWYC3w/X6LXKszicUiIA0Toh6QzZtQ=;
 b=exbE9SU8hZbjX/2sDF03G2o/YBFLotmaeYFu0IamW/Af/YgfsSQvYcQGQpRY95nzLon82d
 Zl83uoHtKbLMf4qtmPQVO9PS2rMEWT7cTw6B+2vVpjCNUaSImuNIMh+LrL8ynZ/2xSPK0n
 82X2HqnavDyZ3rl7eVDL600CBZo7BLk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-214-EdkpEs06Ou6r7LN4QsYqQQ-1; Thu, 28 Nov 2019 10:45:33 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6CB46106B329;
 Thu, 28 Nov 2019 15:45:32 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.43.2.160])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id ABCCD608C2;
 Thu, 28 Nov 2019 15:45:27 +0000 (UTC)
Date: Thu, 28 Nov 2019 16:45:25 +0100
From: Andrew Jones <drjones@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [kvm-unit-tests PATCH v2] Switch the order of the parameters in
 report() and report_xfail()
Message-ID: <20191128154525.xnrzzxtxacldrh7n@kamzik.brq.redhat.com>
References: <20191128071453.15114-1-thuth@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191128071453.15114-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: EdkpEs06Ou6r7LN4QsYqQQ-1
X-Mimecast-Spam-Score: 0
Content-Disposition: inline
Cc: Laurent Vivier <lvivier@redhat.com>, kvm@vger.kernel.org,
 David Hildenbrand <david@redhat.com>, kvm-ppc@vger.kernel.org,
 Bill Wendling <morbo@google.com>, Paolo Bonzini <pbonzini@redhat.com>,
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

On Thu, Nov 28, 2019 at 08:14:53AM +0100, Thomas Huth wrote:
> Commit c09c54c66b1df ("lib: use an argument which doesn't require
> default argument promotion") fixed a warning that occurs with Clang,
> but introduced a regression: If the "pass" parameter is a value
> which has only set the condition bits in the upper 32 bits of a
> 64 bit value, the condition is now false since the value is truncated
> to "unsigned int" so that the upper bits are simply discarded.
> 
> We fixed it by reverting the commit, but that of course also means
> trouble with Clang again. We can not use "bool" if it is the last
> parameter before the variable argument list. The proper fix is to
> swap the parameters around and make the format string the last
> parameter.
> 
> This patch (except the changes in lib/libcflat.h and lib/report.c
> and some rebase conflicts along the way) has basically been created
> with following coccinelle script (with some additional manual tweaking
> of long and disabled lines afterwards):
> 
> @@
> expression fmt;
> expression pass;
> expression list args;
> @@
>  report(
> -fmt, pass
> +pass, fmt
>  , args);
> 
> @@
> expression fmt;
> expression pass;
> expression list args;
> @@
>  report_xfail(
> -fmt, xfail, pass
> +xfail, pass, fmt
>  , args);
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  v2: Rebase the patch to the current master branch
>

Tested on arm and arm64.

Tested-by: Andrew Jones <drjones@redhat.com>

Thanks,
drew

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
