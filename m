Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id C230C3D733B
	for <lists+kvmarm@lfdr.de>; Tue, 27 Jul 2021 12:29:59 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 1F3CB4A534;
	Tue, 27 Jul 2021 06:29:57 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.91
X-Spam-Level: 
X-Spam-Status: No, score=0.91 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_ADSP_CUSTOM_MED=0.001, DKIM_SIGNED=0.1,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_NONE=-0.0001,
	T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@google.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KvVLyl+IkAZ3; Tue, 27 Jul 2021 06:29:57 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 03E4A4A500;
	Tue, 27 Jul 2021 06:29:56 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 5B0D24A023
 for <kvmarm@lists.cs.columbia.edu>; Tue, 27 Jul 2021 06:29:54 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dQ7nx08zVT2X for <kvmarm@lists.cs.columbia.edu>;
 Tue, 27 Jul 2021 06:29:53 -0400 (EDT)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com
 [209.85.221.51])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 3BCAB49F6C
 for <kvmarm@lists.cs.columbia.edu>; Tue, 27 Jul 2021 06:29:53 -0400 (EDT)
Received: by mail-wr1-f51.google.com with SMTP id p5so9473574wro.7
 for <kvmarm@lists.cs.columbia.edu>; Tue, 27 Jul 2021 03:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=sEVmfuf6SAseKM7IhWi4Jb0Zlgwxa7yzUBD2vot0gXo=;
 b=jbMwd6Vf/veIiSMmFyck6MkZinWyb8unn2adULZu5hHXgBtUJvqcr7kHGRoDFsLTVF
 Ht499ehIBB/nonP+vrMAjoWud6FMfahyup+Xc0MfU/qds5iHMcnX9oDDtGxhXfsmw2jQ
 bOA+6T18uhuWrPr7HOF9DqvemNutUfebyAiFbMmlsk90+4cfzU35BkGVuzCOjlJzHABS
 Cpt4iwJFPDMjI6lmrKwLeQlrPdYPUWBMpzRnzxhv7u586fgB5yOFDr74Z++FKEHYj7hv
 vjMZy3Xh3I1JPjwJNfnFXsagRYMzf2VQSW6ySqNJ1lvGEY6NX0bBn2Dlb5HaqspF7peF
 dfMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=sEVmfuf6SAseKM7IhWi4Jb0Zlgwxa7yzUBD2vot0gXo=;
 b=WLHe96BYlltJ8e1e68H+SeBNouErDwa4Ev5MVgiv48zl0x1aqEIOX5jDq+7sCWQTjD
 o37R6TRZRwV3s/6t9WSbR1a1viHSNq3u+XxlbFv5WY1wvSnkrgYgX/zR4yjt8zA25x25
 qCBqC7yhPHcbIe6I7dsysBrql4xWfdoOqNMXGZISrkuyMfK5bUbbGRUOUp6YIYkFyahx
 MZGUkBM+NRfjb9QzaSJWsjL/1EpPgBVhFhTgvBl0DtYVJ9GA6FmIfGkCEFBxgKdnTNDI
 X2FS7OOaTgTuHFbCu6N5JuSTNFCKMbylqgSbr13YgUJauQz5ez4JUP2Nv2fPbC6WYA/4
 ZpNA==
X-Gm-Message-State: AOAM532V8+oLeuzhprcFk0cec9BFEqXBs0VvbUmUHI7ZSHg++zFMClhN
 e8/sWexfM0yv3R9qUBSCb6J2ag==
X-Google-Smtp-Source: ABdhPJyl4ddC3yvRFr3OUCBwgPccE+P0sn15kKofTfKQowfSw6BB1YRonRXV/ZY3mD3e5qu7Ph1vew==
X-Received: by 2002:adf:f64b:: with SMTP id x11mr14340461wrp.155.1627381791958; 
 Tue, 27 Jul 2021 03:29:51 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:210:c468:e033:fa2b:3a6])
 by smtp.gmail.com with ESMTPSA id w18sm2928774wrg.68.2021.07.27.03.29.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jul 2021 03:29:51 -0700 (PDT)
Date: Tue, 27 Jul 2021 11:29:48 +0100
From: Quentin Perret <qperret@google.com>
To: Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH v2 1/6] KVM: arm64: Introduce helper to retrieve a PTE
 and its level
Message-ID: <YP/gHGfhXgBBe7iD@google.com>
References: <20210726153552.1535838-1-maz@kernel.org>
 <20210726153552.1535838-2-maz@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210726153552.1535838-2-maz@kernel.org>
Cc: kernel-team@android.com, kvm@vger.kernel.org,
 Sean Christopherson <seanjc@google.com>, Matthew Wilcox <willy@infradead.org>,
 linux-mm@kvack.org, Paolo Bonzini <pbonzini@redhat.com>,
 Will Deacon <will@kernel.org>, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org
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

On Monday 26 Jul 2021 at 16:35:47 (+0100), Marc Zyngier wrote:
> It is becoming a common need to fetch the PTE for a given address
> together with its level. Add such a helper.

Reviewed-by: Quentin Perret <qperret@google.com>

Thanks,
Quentin
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
