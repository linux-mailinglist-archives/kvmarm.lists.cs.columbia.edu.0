Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 60B90265C4C
	for <lists+kvmarm@lfdr.de>; Fri, 11 Sep 2020 11:16:18 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 132644B32E;
	Fri, 11 Sep 2020 05:16:18 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.911
X-Spam-Level: 
X-Spam-Status: No, score=0.911 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_ADSP_CUSTOM_MED=0.001, DKIM_SIGNED=0.1,
	DNS_FROM_AHBL_RHSBL=2.699, FREEMAIL_FROM=0.001,
	RCVD_IN_DNSWL_NONE=-0.0001, T_DKIM_INVALID=0.01] autolearn=no
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@gmail.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0iiTncw9hQTb; Fri, 11 Sep 2020 05:16:16 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 8CA3A4B358;
	Fri, 11 Sep 2020 05:16:15 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 1F31F4B314
 for <kvmarm@lists.cs.columbia.edu>; Fri, 11 Sep 2020 04:46:20 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EHOM+UztczEk for <kvmarm@lists.cs.columbia.edu>;
 Fri, 11 Sep 2020 04:46:19 -0400 (EDT)
Received: from mail-pg1-f195.google.com (mail-pg1-f195.google.com
 [209.85.215.195])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 04A0E4B312
 for <kvmarm@lists.cs.columbia.edu>; Fri, 11 Sep 2020 04:46:19 -0400 (EDT)
Received: by mail-pg1-f195.google.com with SMTP id g29so6177449pgl.2
 for <kvmarm@lists.cs.columbia.edu>; Fri, 11 Sep 2020 01:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=1GkA0UL55bpOzq1799709zbI1L7Jh544dh/Usr44kfY=;
 b=Qlm5X4knHMrYRafI9yPXpq/lAMmN7kMUumWHzSyktdaHpfYBjRf1L0i48OjrFnD4fM
 QC5/LOrJI4cjoM4qJqWw9UqmT0WvVcjx03RbQaUbQLjEmaxWdw1M/dcHa0maDsXfUJ0W
 wM5ZIAfEEoRPx0B/75qP+WTBhhOJylPJkkUHV79aUXsMANVTl3BIpBjXp4ena4YTrf1r
 3mxNqotZn8thYnV+HLFlVfvzhOmi1AOSCxKWWohGR0wi+6t8I1S4276qyF/Y6m44RkZl
 jJfGxLqFjGk/gV5j3dHxwjKVa7HqscPsihjNOTSQqVx1Vjca8hPk22xcCdmXm/Jlj+Uy
 6K+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=1GkA0UL55bpOzq1799709zbI1L7Jh544dh/Usr44kfY=;
 b=tfpgwsiM9J+bgWrOVbQOeQmQ8eVkFEpOT9RvkxFD872j/kHsj+Cwh/Xj4dt1QkD1LB
 +M+qCGd7djRqZrzxUOXYBb7PigOQKZRWvJwf3GXF8rA87ftElkjr2Nx46Lq0IRTjtI44
 qc/DKbz+zjsfep7D6O4150w4Zk6HUh5oYi12kFZoxa6XcopVu1U1H8vFyOkG6bsiDbT0
 fccVcXFM5eA+hVCwGYV7hukZl1t7pwiaJb0OPrb6lLBPRaBEn2bcd5U9qb1cY1tcVy72
 h9aqJbl3ro7rWlERN1YLRuFTg+Gq9VpWN+ju1KGZhs+ZxvBEEUPkSd68hLrGprHRTW+f
 HYtA==
X-Gm-Message-State: AOAM531SmZMXwhoEPmmLe7p2Y3Wh1dprWbOhpYL4DNSzQt10kORIMasY
 lQrFXbA8IMqitZiBkKcA1D4=
X-Google-Smtp-Source: ABdhPJy14gOgqqZY97TQbIkEVgxM3qq0OMF4Cuu0NkODRuyBetn3P5gFLShii+KjF6Qfx1erVNJ0hg==
X-Received: by 2002:a17:902:fe08:: with SMTP id
 g8mr1051664plj.122.1599813977903; 
 Fri, 11 Sep 2020 01:46:17 -0700 (PDT)
Received: from localhost ([2409:10:2e40:5100:6e29:95ff:fe2d:8f34])
 by smtp.gmail.com with ESMTPSA id k3sm1602956pfp.41.2020.09.11.01.46.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2020 01:46:16 -0700 (PDT)
Date: Fri, 11 Sep 2020 17:46:13 +0900
From: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To: yezengruan <yezengruan@huawei.com>
Subject: Re: [RFC][PATCH 0/4] arm64:kvm: teach guest sched that VCPUs can be
 preempted
Message-ID: <20200911084613.GA562@jagdpanzerIV.localdomain>
References: <20200721041742.197354-1-sergey.senozhatsky@gmail.com>
 <20200817020310.GA1210848@jagdpanzerIV.localdomain>
 <fe72592c-c721-bece-1469-95eebf931299@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <fe72592c-c721-bece-1469-95eebf931299@huawei.com>
X-Mailman-Approved-At: Fri, 11 Sep 2020 05:16:14 -0400
Cc: joelaf@google.com, "maz@kernel.org" <maz@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, suleiman@google.com,
 "will@kernel.org" <will@kernel.org>,
 "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
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

Hi,

On (20/08/17 20:03), yezengruan wrote:
> Hi Sergey,
> 
> I have a set of patches similar to yours.
> 
> https://lore.kernel.org/lkml/20191226135833.1052-1-yezengruan@huawei.com/

I'm sorry for the belated reply.

Right, quite similar, but not exactly, I believe. I deliberately wanted
to untangle vcpu preemption (which is a characteristics feature) from
pv-lock, which may be somewhat implementation dependent.

Perhaps vcpu_is_preempted() should not even be implemented on per-arch
basis, but instead it can be more of a "core" functionality.

	-ss
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
