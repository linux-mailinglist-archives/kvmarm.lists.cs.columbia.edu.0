Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 2CABE5595D1
	for <lists+kvmarm@lfdr.de>; Fri, 24 Jun 2022 10:55:18 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 19DB340C29;
	Fri, 24 Jun 2022 04:55:17 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.789
X-Spam-Level: 
X-Spam-Status: No, score=-1.789 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, T_DKIM_INVALID=0.01, URIBL_BLOCKED=0.001]
	autolearn=no
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@redhat.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id F8hy2MRjtt4J; Fri, 24 Jun 2022 04:55:16 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 1BC6D41014;
	Fri, 24 Jun 2022 04:55:15 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 16F9540C23
 for <kvmarm@lists.cs.columbia.edu>; Fri, 24 Jun 2022 04:55:14 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Zn3LDdAkvQX0 for <kvmarm@lists.cs.columbia.edu>;
 Fri, 24 Jun 2022 04:55:13 -0400 (EDT)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 0DF3340BA3
 for <kvmarm@lists.cs.columbia.edu>; Fri, 24 Jun 2022 04:55:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1656060912;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=clZcKvLIlaSI0aj01C5lBcQXLk+ikl+B/lRxtrhuDg5wwkqdYF5UPGMlnYSf0lpgXhCWYT
 gls4LxDtou6pAKKKlV+4NFGPA7Of0TZclZCdFuJWDN30JduJvike14IeynA/GPT59zCXzZ
 nLJPAC8DViQwIpulrZlJ8I7gTkkG5jQ=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-492-8kQPj_gwPha5AfRxe-hGEg-1; Fri, 24 Jun 2022 04:55:08 -0400
X-MC-Unique: 8kQPj_gwPha5AfRxe-hGEg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5B6A61C06915;
 Fri, 24 Jun 2022 08:55:07 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E3893C53360;
 Fri, 24 Jun 2022 08:55:06 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Andrew Jones <drjones@redhat.com>
Subject: Re: [PATCH kvm-unit-tests] MAINTAINERS: Change drew's email address
Date: Fri, 24 Jun 2022 04:55:06 -0400
Message-Id: <20220624085506.2731362-1-pbonzini@redhat.com>
In-Reply-To: <20220623131017.670589-1-drjones@redhat.com>
References: 
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
Cc: maz@kernel.org, thuth@redhat.com, kvm@vger.kernel.org,
 qemu-devel@nongnu.org, nikos.nikoleris@arm.com, qemu-arm@nongnu.org,
 andre.przywara@arm.com, pbonzini@redhat.com, kvmarm@lists.cs.columbia.edu
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

Queued, thanks.

Paolo


_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
